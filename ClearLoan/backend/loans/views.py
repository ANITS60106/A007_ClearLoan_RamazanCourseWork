from rest_framework import generics, permissions
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import LoanOffer, ActiveLoan, LoanRequest
from .serializers import LoanOfferSerializer, ActiveLoanSerializer, LoanRequestSerializer

class OffersListView(generics.ListAPIView):
    queryset = LoanOffer.objects.all().order_by('rate')
    serializer_class = LoanOfferSerializer
    permission_classes = [permissions.AllowAny]

class ActiveLoansView(generics.ListCreateAPIView):
    serializer_class = ActiveLoanSerializer

    def get_queryset(self):
        return ActiveLoan.objects.filter(user=self.request.user).order_by('-id')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class LoanRequestsView(generics.ListCreateAPIView):
    serializer_class = LoanRequestSerializer

    def get_queryset(self):
        return LoanRequest.objects.filter(user=self.request.user).order_by('-id')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class SeedOffersView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        # Simple seed for demo (idempotent-ish)
        defaults = [
            ('Aiyl Bank', 18.0, 36, 300000),
            ('Optima Bank', 20.0, 24, 200000),
            ('MBank', 22.0, 18, 150000),
            ('Bakai Bank', 23.0, 12, 100000),
        ]
        for name, rate, months, max_amount in defaults:
            LoanOffer.objects.get_or_create(
                provider_name=name,
                rate=rate,
                months=months,
                max_amount=max_amount,
            )
        return Response({'detail': 'seeded'})
