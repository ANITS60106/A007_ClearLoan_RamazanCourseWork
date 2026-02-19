import 'package:flutter/material.dart';
import '../services/i18n.dart';
import '../services/loans_service.dart';
import '../widgets/app_card.dart';

class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('loans'))),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: LoansService.loans,
          builder: (context, loans, _) {
            if (loans.isEmpty) {
              return Center(
                child: Text(
                  'No active loans yet',
                  style: TextStyle(color: Colors.black.withOpacity(0.55)),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: loans.length,
              itemBuilder: (context, i) {
                final l = loans[i];
                return AppCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l.bankName, style: const TextStyle(fontWeight: FontWeight.w900)),
                            const SizedBox(height: 6),
                            Text(
                              '${l.amount} сом • ${l.months} мес. • ${l.rate.toStringAsFixed(0)}%',
                              style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Monthly: ${l.monthlyPayment} сом',
                              style: TextStyle(color: cs.primary, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => LoansService.removeAt(i),
                        icon: Icon(Icons.delete_outline, color: cs.error),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
