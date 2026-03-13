from datetime import date, timedelta
import random

from django.contrib.auth import get_user_model

from .models import Bank, BankBranch, LoanProduct, CreditHistoryEntry, ActiveLoan, AppNotification, BankRating


def seed_banks_and_products():
    banks = [
        {
            "code": "aiyl-bank",
            "name_en": "Aiyl Bank",
            "name_ru": "Айыл Банк",
            "name_ky": "Айыл Банк",
            "website": "https://ab.kg/en/",
            "support_phone": "5511",
            "hq": {"en": "Bishkek, 14 Logvinenko St.", "ru": "г. Бишкек, ул. Логвиненко, 14", "ky": "Бишкек, Логвиненко көч., 14"},
            "about": {
                "en": "Aiyl Bank is a large Kyrgyz bank with strong regional infrastructure, social programs, agricultural finance and Islamic finance products.",
                "ru": "Айыл Банк — крупный банк Кыргызстана с сильной региональной сетью, социальными программами, агрофинансированием и исламскими продуктами.",
                "ky": "Айыл Банк — аймактык тармагы күчтүү, социалдык жана агрардык каржылоо, исламдык продуктылары бар ири банк."
            },
            "branches": [{"city": "Bishkek", "en": "14 Logvinenko St.", "ru": "ул. Логвиненко, 14", "ky": "Логвиненко көч., 14", "hours": "Mon–Fri 08:30–17:30"}],
            "products": [
                {"loan_type": "consumer", "title_en": "Consumer Loan", "title_ru": "Потребительский кредит", "title_ky": "Керектөөчү насыя", "min_amount": 10000, "max_amount": 500000, "min_months": 3, "max_months": 24, "rate_from": 14.0, "rate_to": 22.0, "collateral": "none", "is_islamic": False, "desc_en": "Consumer loan for everyday needs.", "desc_ru": "Потребительский кредит на бытовые нужды.", "desc_ky": "Күнүмдүк муктаждыктар үчүн насыя."},
                {"loan_type": "mortgage", "title_en": "Mortgage Loan", "title_ru": "Ипотечный кредит", "title_ky": "Ипотекалык насыя", "min_amount": 300000, "max_amount": 6000000, "min_months": 12, "max_months": 240, "rate_from": 13.0, "rate_to": 18.0, "collateral": "real estate", "is_islamic": False, "desc_en": "Mortgage for housing purchase.", "desc_ru": "Ипотека на покупку жилья.", "desc_ky": "Турак жай алуу үчүн ипотека."},
                {"loan_type": "business", "title_en": "Islamic Business Financing", "title_ru": "Исламское бизнес-финансирование", "title_ky": "Исламдык бизнес каржылоо", "min_amount": 50000, "max_amount": 1500000, "min_months": 6, "max_months": 60, "rate_from": 12.0, "rate_to": 16.0, "collateral": "guarantor", "is_islamic": True, "desc_en": "Sharia-compliant business financing.", "desc_ru": "Шариат-совместимое бизнес-финансирование.", "desc_ky": "Шариятка ылайык бизнес каржылоо."},
            ],
        },
        {
            "code": "optima-bank",
            "name_en": "Optima Bank",
            "name_ru": "Оптима Банк",
            "name_ky": "Оптима Банк",
            "website": "https://optimabank.kg/en/",
            "support_phone": "905959",
            "hq": {"en": "Bishkek, 493 Jibek-Jolu str.", "ru": "г. Бишкек, ул. Жибек-Жолу, 493", "ky": "Бишкек, Жибек-Жолу көч., 493"},
            "about": {"en": "Retail-focused bank with strong consumer products, cards and digital services.", "ru": "Розничный банк с сильными потребительскими продуктами, картами и цифровыми сервисами.", "ky": "Керектөөчү продуктылар, карталар жана санарип кызматтары күчтүү банк."},
            "branches": [{"city": "Bishkek", "en": "493 Jibek-Jolu str.", "ru": "ул. Жибек-Жолу, 493", "ky": "Жибек-Жолу көч., 493", "hours": "Mon–Fri 09:00–18:00"}],
            "products": [
                {"loan_type": "consumer", "title_en": "Fast Consumer Loan", "title_ru": "Быстрый потребительский кредит", "title_ky": "Тез керектөөчү насыя", "min_amount": 15000, "max_amount": 700000, "min_months": 3, "max_months": 48, "rate_from": 19.0, "rate_to": 25.0, "collateral": "none", "is_islamic": False, "desc_en": "Quick consumer financing.", "desc_ru": "Быстрое потребительское финансирование.", "desc_ky": "Тез керектөөчү каржылоо."},
                {"loan_type": "auto", "title_en": "Auto Loan", "title_ru": "Автокредит", "title_ky": "Автонасыя", "min_amount": 100000, "max_amount": 2500000, "min_months": 12, "max_months": 84, "rate_from": 16.0, "rate_to": 20.0, "collateral": "vehicle", "is_islamic": False, "desc_en": "Loan for vehicle purchase.", "desc_ru": "Кредит на покупку автомобиля.", "desc_ky": "Унаа сатып алуу үчүн насыя."},
            ],
        },
        {
            "code": "demir-bank",
            "name_en": "Demir Bank",
            "name_ru": "Демир Банк",
            "name_ky": "Демир Банк",
            "website": "https://demirbank.kg/en/",
            "support_phone": "+996 (312) 610610",
            "hq": {"en": "Bishkek, 245 Chui Ave.", "ru": "г. Бишкек, пр. Чүй, 245", "ky": "Бишкек, Чүй пр., 245"},
            "about": {"en": "One of the oldest private banks in Kyrgyzstan with strong retail and SME services.", "ru": "Один из старейших частных банков Кыргызстана с сильными розничными и SME сервисами.", "ky": "Кыргызстандагы эң эски жеке банктардын бири, чекене жана SME кызматтары күчтүү."},
            "branches": [{"city": "Bishkek", "en": "245 Chui Ave.", "ru": "пр. Чүй, 245", "ky": "Чүй пр., 245", "hours": "Mon–Fri 09:00–17:00"}],
            "products": [
                {"loan_type": "consumer", "title_en": "Personal Loan", "title_ru": "Персональный кредит", "title_ky": "Жеке насыя", "min_amount": 20000, "max_amount": 600000, "min_months": 6, "max_months": 60, "rate_from": 18.0, "rate_to": 23.0, "collateral": "none", "is_islamic": False, "desc_en": "Personal loan for various needs.", "desc_ru": "Персональный кредит на разные нужды.", "desc_ky": "Ар кандай муктаждыктар үчүн жеке насыя."},
                {"loan_type": "business", "title_en": "Islamic Financing", "title_ru": "Исламское финансирование", "title_ky": "Исламдык каржылоо", "min_amount": 50000, "max_amount": 1200000, "min_months": 6, "max_months": 60, "rate_from": 13.0, "rate_to": 17.0, "collateral": "guarantor", "is_islamic": True, "desc_en": "Islamic finance product compliant with Sharia principles.", "desc_ru": "Исламский финансовый продукт по принципам шариата.", "desc_ky": "Шарият принциптерине ылайык исламдык каржы продукты."},
            ],
        },
        {
            "code": "eldik-bank",
            "name_en": "Eldik Bank",
            "name_ru": "Элдик Банк",
            "name_ky": "Элдик Банк",
            "website": "https://eldik.kg/en",
            "support_phone": "9111",
            "hq": {"en": "Bishkek, 80/1 Moskovskaya St.", "ru": "г. Бишкек, ул. Московская, 80/1", "ky": "Бишкек, Московская көч., 80/1"},
            "about": {"en": "Large state bank with universal retail loan products.", "ru": "Крупный государственный банк с универсальными кредитными продуктами.", "ky": "Универсал насыя продуктылары бар ири мамлекеттик банк."},
            "branches": [{"city": "Bishkek", "en": "80/1 Moskovskaya St.", "ru": "ул. Московская, 80/1", "ky": "Московская көч., 80/1", "hours": "Mon–Fri 09:00–18:00"}],
            "products": [
                {"loan_type": "consumer", "title_en": "Consumer Credit", "title_ru": "Потребительский кредит", "title_ky": "Керектөөчү насыя", "min_amount": 10000, "max_amount": 4000000, "min_months": 3, "max_months": 60, "rate_from": 19.0, "rate_to": 30.0, "collateral": "depends", "is_islamic": False, "desc_en": "Consumer credit for different needs.", "desc_ru": "Потребительский кредит для разных нужд.", "desc_ky": "Ар кандай муктаждык үчүн керектөөчү насыя."},
                {"loan_type": "business", "title_en": "Islamic SME Financing", "title_ru": "Исламское финансирование МСБ", "title_ky": "Исламдык ЧОБ каржылоо", "min_amount": 100000, "max_amount": 2000000, "min_months": 6, "max_months": 60, "rate_from": 14.0, "rate_to": 18.0, "collateral": "guarantor", "is_islamic": True, "desc_en": "Islamic financing for SME growth.", "desc_ru": "Исламское финансирование для развития МСБ.", "desc_ky": "ЧОБ өнүктүрүү үчүн исламдык каржылоо."},
            ],
        },
    ]

    for b in banks:
        bank, _ = Bank.objects.update_or_create(
            code=b['code'],
            defaults=dict(
                name_en=b['name_en'], name_ru=b['name_ru'], name_ky=b['name_ky'],
                website=b['website'], support_phone=b['support_phone'],
                hq_address_en=b['hq']['en'], hq_address_ru=b['hq']['ru'], hq_address_ky=b['hq']['ky'],
                about_en=b['about']['en'], about_ru=b['about']['ru'], about_ky=b['about']['ky'],
                email_domain=f"{b['code']}.kg", notification_email=f"credit.applications@{b['code']}.kg",
            )
        )
        BankBranch.objects.filter(bank=bank).delete()
        LoanProduct.objects.filter(bank=bank).delete()
        for br in b['branches']:
            BankBranch.objects.create(bank=bank, city=br['city'], address_en=br['en'], address_ru=br['ru'], address_ky=br['ky'], hours=br['hours'])
        for p in b['products']:
            LoanProduct.objects.create(bank=bank, **p)


def seed_fake_users_with_histories(count: int = 25):
    User = get_user_model()
    providers = ["Aiyl Bank", "Optima Bank", "Demir Bank", "Eldik Bank"]
    occupations = ["Student", "Teacher", "Driver", "Software Developer", "Sales Manager", "Doctor", "Accountant", "Self-employed", "Farmer", "Office Worker"]
    names = ["Aibek", "Ainura", "Ramazan", "Bakyt", "Meerim", "Nursultan", "Aigerim", "Erbol", "Kanykei", "Adilet"]
    for i in range(count):
        phone = f"+996700{100000 + i}"
        user, created = User.objects.get_or_create(
            phone=phone,
            defaults=dict(
                full_name=f"{random.choice(names)} Demo {i+1}",
                passport_id=f"AN{1000000+i}",
                workplace="Demo workplace",
                occupation=random.choice(occupations),
                monthly_income=random.choice([18000, 25000, 32000, 45000, 60000, 80000, 120000]),
                user_type='individual',
                role='client',
            )
        )
        if created:
            user.set_password('demo12345')
            user.save()
        CreditHistoryEntry.objects.filter(user=user).delete()
        ActiveLoan.objects.filter(user=user).delete()
        AppNotification.objects.filter(user=user).delete()

        mode = 'clean' if i < 7 else 'late' if i < 13 else 'mixed' if i < 19 else 'default' if i < 22 else 'none'
        if mode == 'none':
            AppNotification.objects.create(user=user, title='Welcome to ClearLoan', message='Your profile has no credit history yet. You can still request loans.', category='info')
            continue
        for idx in range(random.randint(2, 4) if mode != 'default' else random.randint(1, 2)):
            status = 'ontime'
            late_payments = 0
            note = ''
            if mode == 'late':
                status = 'late'; late_payments = random.randint(1, 2); note = 'Yellow zone delay.'
            elif mode == 'mixed':
                status = random.choice(['ontime','late']); late_payments = 0 if status=='ontime' else random.randint(1,3)
            elif mode == 'default':
                status = 'default'; late_payments = random.randint(8, 14); note = 'Red zone default.'
            CreditHistoryEntry.objects.create(
                user=user, provider_name=random.choice(providers), original_amount=random.choice([50000,100000,200000,300000,500000]),
                opened_at=date.today()-timedelta(days=random.randint(200,1800)), closed_at=None if status=='default' else date.today()-timedelta(days=random.randint(10,180)),
                status=status, late_payments=late_payments, note=note,
            )
        if mode in ['clean','late','mixed'] and random.random() < 0.7:
            amt = random.choice([40000,80000,150000,250000,400000])
            m = random.choice([6,12,18,24,36])
            r = random.choice([18.0,22.0,26.0])
            ActiveLoan.objects.create(user=user, provider_name=random.choice(providers), amount=amt, months=m, rate=r, monthly_payment=int((amt*(1+r/100))/m), status='active')
        AppNotification.objects.create(user=user, title='Profile prepared', message=f'Demo user created with {mode} credit profile.', category='info')


def seed_bank_admins_and_staff():
    User = get_user_model()
    banks = list(Bank.objects.all().order_by('code'))
    base = 200000
    for idx, bank in enumerate(banks):
        admin_phone = f"+996555{base + idx:06d}"
        admin, created = User.objects.get_or_create(
            phone=admin_phone,
            defaults=dict(full_name=f"{bank.name_en} Admin", workplace=bank.name_en, occupation='Bank administrator', monthly_income=200000, user_type='legal', role='bank_admin', bank=bank, email=f"admin@{bank.email_domain}", is_staff=True)
        )
        if created:
            admin.set_password('demo12345'); admin.save()
        staff_phone = f"+996556{base + idx:06d}"
        staff, created = User.objects.get_or_create(
            phone=staff_phone,
            defaults=dict(full_name=f"{bank.name_en} Specialist", workplace=bank.name_en, occupation='Credit specialist', monthly_income=150000, user_type='legal', role='bank_staff', bank=bank, email=f"credit.specialist@{bank.email_domain}", is_staff=True)
        )
        if created:
            staff.set_password('demo12345'); staff.save()
        AppNotification.objects.get_or_create(user=admin, title='Admin account ready', defaults={'message': f'Bank admin account linked to {bank.name_en}.', 'category': 'info'})
        AppNotification.objects.get_or_create(user=staff, title='Inbox ready', defaults={'message': f'Loan specialist account linked to {bank.name_en}.', 'category': 'info'})
        # starter ratings
        for score in [4,5,5]:
            rater = User.objects.filter(role='client').order_by('?').first()
            if rater:
                BankRating.objects.get_or_create(bank=bank, user=rater, defaults={'rating': score, 'comment': 'Good service'})
