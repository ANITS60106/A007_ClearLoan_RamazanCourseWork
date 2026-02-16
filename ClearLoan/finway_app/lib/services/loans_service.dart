import 'package:flutter/foundation.dart';
import '../models/active_loan.dart';

class LoansService {
  static final ValueNotifier<List<ActiveLoan>> loans =
      ValueNotifier<List<ActiveLoan>>([
    const ActiveLoan(
      bankName: 'Eldik Bank',
      amount: 45000,
      months: 45,
      rate: 22,
      monthlyPayment: 2300,
    ),
  ]);

  static void addLoan(ActiveLoan loan) {
    loans.value = [...loans.value, loan];
  }

  static void removeAt(int index) {
    final list = [...loans.value];
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      loans.value = list;
    }
  }
}
