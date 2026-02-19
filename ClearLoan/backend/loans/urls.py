from django.urls import path
from .views import OffersListView, ActiveLoansView, LoanRequestsView, SeedOffersView

urlpatterns = [
    path('offers/', OffersListView.as_view()),
    path('loans/', ActiveLoansView.as_view()),
    path('requests/', LoanRequestsView.as_view()),
    path('seed/', SeedOffersView.as_view()),
]
