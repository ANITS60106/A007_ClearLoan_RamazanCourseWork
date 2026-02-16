class ActiveLoan {
  final String bankName;
  final int amount;
  final int months;
  final double rate;
  final int monthlyPayment;

  const ActiveLoan({
    required this.bankName,
    required this.amount,
    required this.months,
    required this.rate,
    required this.monthlyPayment,
  });
}
