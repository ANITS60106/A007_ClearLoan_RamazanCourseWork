import 'package:flutter/material.dart';
import '../services/i18n.dart';

class FinancialLiteracyScreen extends StatelessWidget {
  const FinancialLiteracyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      ('How consumer loans work', 'A consumer loan is usually used for daily needs. You borrow a fixed amount and repay it monthly with interest.'),
      ('How to improve your credit history', 'Pay on time, avoid too many delays, keep monthly payments at a safe level, and do not request unrealistic loan amounts.'),
      ('How to compare bank offers', 'Check interest rate, monthly payment, maximum term, collateral requirements, and approval probability before applying.'),
    ];
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(I18n.t('financial_literacy'), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          ...lessons.map((e) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: cs.outlineVariant.withOpacity(0.55))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.$1, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(e.$2, style: TextStyle(color: cs.onSurface.withOpacity(0.72))),
            ]),
          )),
        ],
      ),
    );
  }
}
