from rest_framework import generics, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authentication import TokenAuthentication
from django.db.models import Q
from django.core.mail import send_mail
from django.conf import settings
from typing import Optional

from .models import (
    LoanOffer,
    ActiveLoan,
    LoanRequest,
    CreditHistoryEntry,
    Bank,
    BankBranch,
    LoanProduct,
    LoanApplication,
)
from .serializers import (
    LoanOfferSerializer,
    ActiveLoanSerializer,
    LoanRequestSerializer,
    CreditHistoryEntrySerializer,
    BankSerializer,
    BankDetailSerializer,
    LoanProductWithBankSerializer,
    LoanApplicationSerializer,
)


class OffersListView(generics.ListAPIView):
    queryset = LoanOffer.objects.all().order_by('rate')
    serializer_class = LoanOfferSerializer
    permission_classes = [permissions.AllowAny]


class BanksListView(generics.ListAPIView):
    queryset = Bank.objects.all().order_by('name_en')
    serializer_class = BankSerializer
    permission_classes = [permissions.AllowAny]


class BankDetailView(generics.RetrieveAPIView):
    queryset = Bank.objects.all()
    serializer_class = BankDetailSerializer
    permission_classes = [permissions.AllowAny]
    lookup_field = 'code'


class LoanProductsListView(generics.ListAPIView):
    """List loan products with server-side filters.

    This endpoint is meant for the Aggregator screen so filters actually remove
    "unprofitable" offers instead of being only UI chips.

    Query params (all optional):
      - q: search in bank and product titles
      - loan_type: consumer/mortgage/auto/business/education
      - filter: all|low|short|long|no_collateral|islamic|high_amount|best_value
    """

    serializer_class = LoanProductWithBankSerializer
    permission_classes = [permissions.AllowAny]

    def get_queryset(self):
        qs = LoanProduct.objects.select_related('bank').all()

        q = (self.request.query_params.get('q') or '').strip().lower()
        loan_type = (self.request.query_params.get('loan_type') or '').strip()
        preset = (self.request.query_params.get('filter') or 'all').strip()

        if loan_type:
            qs = qs.filter(loan_type=loan_type)

        if q:
            # Search across EN/RU/KY names and titles
            qs = qs.filter(
                Q(bank__name_en__icontains=q)
                | Q(bank__name_ru__icontains=q)
                | Q(bank__name_ky__icontains=q)
                | Q(title_en__icontains=q)
                | Q(title_ru__icontains=q)
                | Q(title_ky__icontains=q)
            )

        # Preset filters
        if preset == 'low':
            qs = qs.filter(rate_from__lte=20)
        elif preset == 'short':
            qs = qs.filter(max_months__lte=18)
        elif preset == 'long':
            qs = qs.filter(max_months__gte=60)
        elif preset == 'no_collateral':
            qs = qs.filter(Q(collateral__isnull=True) | Q(collateral__exact='') | Q(collateral__icontains='none') | Q(collateral__icontains='no'))
        elif preset == 'islamic':
            qs = qs.filter(is_islamic=True)
        elif preset == 'high_amount':
            qs = qs.filter(max_amount__gte=1_000_000)
        elif preset == 'best_value':
            # A simple "value" preset: relatively low rates + large limits
            qs = qs.filter(rate_from__lte=22, max_amount__gte=500_000)

        # A stable order for UI
        return qs.order_by('rate_from', '-max_amount')


def _compute_score(user) -> int:
    """A tiny heuristic credit score for a prototype.

    Score range roughly 300..850 (like many real bureaus), but this is NOT real.
    """
    history = CreditHistoryEntry.objects.filter(user=user)
    if not history.exists():
        base = 520
    else:
        base = 600

    for e in history:
        if e.status == 'ontime':
            base += 18
        elif e.status == 'late':
            base -= 45
        elif e.status == 'default':
            base -= 200
        base -= min(e.late_payments, 10) * 4

    income = max(int(getattr(user, 'monthly_income', 0) or 0), 1)
    active = ActiveLoan.objects.filter(user=user, status='active')
    monthly = sum(int(a.monthly_payment or 0) for a in active)
    dti = monthly / income
    if dti > 0.6:
        base -= 120
    elif dti > 0.4:
        base -= 60
    elif dti < 0.25:
        base += 20

    # Small bump for stable occupation
    occupation = (getattr(user, 'occupation', '') or '').lower()
    if any(k in occupation for k in ['engineer', 'developer', 'teacher', 'doctor', 'accountant', 'manager']):
        base += 10

    return max(300, min(850, base))


def _history_block_reason(user) -> Optional[str]:
    """Return a reason string if user should be blocked from submitting applications.

    Rules requested for the prototype demo:
      - If user has >= 1 red event (default / unpaid 3+ months) -> block
      - If user has > 3 yellow events (late payments) -> block
    """
    history = CreditHistoryEntry.objects.filter(user=user)
    if not history.exists():
        return None

    red = history.filter(status='default').count()
    if red >= 1:
        return 'Blocked: red-zone credit history (unpaid 3+ months).'

    # "Yellow" is represented as late payments. We count total late occurrences.
    yellow = 0
    for e in history:
        if e.status == 'late':
            yellow += max(int(e.late_payments or 0), 1)
    if yellow > 3:
        return 'Blocked: too many yellow-zone late payments (> 3).'

    return None


def _max_amount_for_user(user) -> int:
    # Individual clients should not request unrealistic amounts.
    # Legal entities can request significantly more.
    if getattr(user, 'user_type', 'individual') == 'legal':
        return 500_000_000
    return 5_000_000


def _estimate_payment(amount: int, months: int, annual_rate: float) -> int:
    if amount <= 0 or months <= 0:
        return 0
    # Prototype: simple interest approximation (NOT a real amortization schedule)
    return int((amount * (1 + (annual_rate / 100))) / months)


def _approval_probability(score: int, dti: float, annual_rate: float) -> float:
    # Prototype probability model, 0..1
    p = 0.0
    # score influence
    if score >= 740:
        p += 0.55
    elif score >= 680:
        p += 0.45
    elif score >= 620:
        p += 0.35
    elif score >= 560:
        p += 0.25
    else:
        p += 0.12

    # DTI penalty
    if dti <= 0.25:
        p += 0.25
    elif dti <= 0.40:
        p += 0.15
    elif dti <= 0.55:
        p += 0.05
    else:
        p -= 0.15

    # Rate proxy (lower rates -> slightly higher approval)
    if annual_rate <= 18:
        p += 0.07
    elif annual_rate <= 22:
        p += 0.04
    else:
        p -= 0.02

    return max(0.0, min(0.99, p))


class ScoredBankOptionsView(APIView):
    """Return bank+product options sorted by approval probability."""

    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        loan_type = request.query_params.get('loan_type', 'consumer')
        amount = int(request.query_params.get('amount', '0') or 0)
        months = int(request.query_params.get('months', '0') or 0)

        # If user is blocked, still return options but mark as rejected to guide UI.
        block_reason = _history_block_reason(request.user)

        # Enforce user-type limit
        max_allowed = _max_amount_for_user(request.user)
        if amount > max_allowed:
            return Response({
                'score': _compute_score(request.user),
                'options': [],
                'detail': f'Requested amount exceeds the limit for this user type (max {max_allowed}).'
            }, status=400)

        score = _compute_score(request.user)
        income = max(int(getattr(request.user, 'monthly_income', 0) or 0), 1)
        monthly_existing = sum(int(a.monthly_payment or 0) for a in ActiveLoan.objects.filter(user=request.user, status='active'))

        products = LoanProduct.objects.filter(loan_type=loan_type)
        if amount > 0:
            products = products.filter(Q(max_amount=0) | Q(max_amount__gte=amount)).filter(Q(min_amount=0) | Q(min_amount__lte=amount))
        if months > 0:
            products = products.filter(min_months__lte=months, max_months__gte=months)

        options = []
        for p in products.select_related('bank'):
            rate = float(p.rate_from or p.rate_to or 0)
            est_payment = _estimate_payment(amount, months, rate)
            dti = (monthly_existing + est_payment) / income
            prob = _approval_probability(score, dti, rate)

            if block_reason:
                status_lbl = 'rejected'
                prob = 0.0
            elif prob >= 0.70:
                status_lbl = 'approved'
            elif prob >= 0.40:
                status_lbl = 'alternative'
            else:
                status_lbl = 'rejected'

            options.append({
                'product_id': p.id,
                'bank_code': p.bank.code,
                'bank_name_en': p.bank.name_en,
                'bank_name_ru': p.bank.name_ru,
                'bank_name_ky': p.bank.name_ky,
                'product_title_en': p.title_en,
                'product_title_ru': p.title_ru,
                'product_title_ky': p.title_ky,
                'loan_type': p.loan_type,
                'rate_from': p.rate_from,
                'rate_to': p.rate_to,
                'estimated_payment': est_payment,
                'approval_probability': prob,
                'status': status_lbl,
            })

        options.sort(key=lambda x: x['approval_probability'], reverse=True)
        resp = {'score': score, 'options': options}
        if block_reason:
            resp['detail'] = block_reason
        return Response(resp)


class ApplyForLoanView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        product_id = int(request.data.get('product_id'))
        amount = int(request.data.get('amount'))
        months = int(request.data.get('months'))

        # Hard filters to avoid sending "trash" applications to bank staff
        block_reason = _history_block_reason(request.user)
        if block_reason:
            return Response({'detail': block_reason}, status=422)

        max_allowed = _max_amount_for_user(request.user)
        if amount > max_allowed:
            return Response({'detail': f'Requested amount exceeds the limit for this user type (max {max_allowed}).'}, status=400)

        product = LoanProduct.objects.select_related('bank').get(id=product_id)

        score = _compute_score(request.user)
        income = max(int(getattr(request.user, 'monthly_income', 0) or 0), 1)
        monthly_existing = sum(int(a.monthly_payment or 0) for a in ActiveLoan.objects.filter(user=request.user, status='active'))

        rate = float(product.rate_from or product.rate_to or 0)
        est_payment = _estimate_payment(amount, months, rate)
        dti = (monthly_existing + est_payment) / income
        prob = _approval_probability(score, dti, rate)

        if prob >= 0.70:
            status_lbl = 'approved'
        elif prob >= 0.40:
            status_lbl = 'alternative'
        else:
            status_lbl = 'rejected'

        app = LoanApplication.objects.create(
            user=request.user,
            product=product,
            amount=amount,
            months=months,
            monthly_payment=est_payment,
            decision_status=status_lbl,
            approval_probability=prob,
        )

        # For demo: if approved, add to active loans (acts like a "basket" tracking)
        if status_lbl == 'approved':
            ActiveLoan.objects.create(
                user=request.user,
                provider_name=product.bank.name_en,
                amount=amount,
                months=months,
                rate=rate,
                monthly_payment=est_payment,
                status='active',
            )

        # Send a prototype email notification to bank employees.
        # For this student demo we always send a copy to the test address.
        try:
            bank_email = (product.bank.notification_email or '').strip()
            recipients = [e for e in [bank_email, getattr(settings, 'DEMO_APPLICATIONS_EMAIL', '')] if e]
            if recipients:
                subject = f"ClearLoan application: {product.bank.name_en} / {product.title_en}"
                body = (
                    f"New loan application (prototype)\n\n"
                    f"Client: {getattr(request.user, 'full_name', '')} ({request.user.phone})\n"
                    f"User type: {getattr(request.user, 'user_type', 'individual')}\n"
                    f"Requested: {amount} KGS for {months} months\n"
                    f"Estimated monthly payment: {est_payment} KGS\n"
                    f"Decision: {status_lbl} (p={prob:.2f})\n\n"
                    f"This is a demo email sent by ClearLoan prototype."
                )
                send_mail(subject, body, getattr(settings, 'DEFAULT_FROM_EMAIL', 'no-reply@clearloan.local'), recipients, fail_silently=True)
        except Exception:
            pass

        return Response(LoanApplicationSerializer(app).data)


class LoanApplicationsView(generics.ListAPIView):
    serializer_class = LoanApplicationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return LoanApplication.objects.filter(user=self.request.user)


class BankInboxApplicationsView(generics.ListAPIView):
    """Inbox for bank employees (admin/staff).

    Shows applications submitted to the employee's bank.
    """

    serializer_class = LoanApplicationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        u = self.request.user
        if getattr(u, 'role', 'client') not in ['bank_admin', 'bank_staff']:
            return LoanApplication.objects.none()
        bank = getattr(u, 'bank', None)
        if not bank:
            return LoanApplication.objects.none()

        qs = LoanApplication.objects.select_related('product', 'product__bank', 'user').filter(product__bank=bank)

        status = (self.request.query_params.get('status') or '').strip()
        if status:
            qs = qs.filter(decision_status=status)

        # Prioritize clean/empty credit history and higher approval probability
        return qs.order_by('-approval_probability', '-created_at')


class ActiveLoansView(generics.ListCreateAPIView):
    serializer_class = ActiveLoanSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return ActiveLoan.objects.filter(user=self.request.user).order_by('-id')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class LoanRequestsView(generics.ListCreateAPIView):
    serializer_class = LoanRequestSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return LoanRequest.objects.filter(user=self.request.user).order_by('-id')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class CreditHistoryView(generics.ListCreateAPIView):
    serializer_class = CreditHistoryEntrySerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return CreditHistoryEntry.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class CreditHistorySummaryView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        score = _compute_score(request.user)
        history = CreditHistoryEntry.objects.filter(user=request.user)
        counts = {
            'ontime': history.filter(status='ontime').count(),
            'late': history.filter(status='late').count(),
            'default': history.filter(status='default').count(),
        }
        return Response({'score': score, 'counts': counts})


class SeedDemoDataView(APIView):
    """Seed demo banks/products (idempotent-ish)."""
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        from .seed import seed_banks_and_products
        seed_banks_and_products()
        return Response({'detail': 'seeded'})
