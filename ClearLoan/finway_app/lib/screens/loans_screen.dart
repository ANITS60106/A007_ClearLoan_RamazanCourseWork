import 'package:flutter/material.dart';
import '../services/loans_service.dart';

class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Loans')),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: LoansService.loans,
          builder: (context, loans, _) {
            if (loans.isEmpty) {
              return Center(
                child: Text(
                  'No active loans yet',
                  style: TextStyle(color: Colors.white.withOpacity(0.75)),
                ),
              );
            }

            return ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, i) {
                final l = loans[i];
                return Card(
                  child: ListTile(
                    title: Text(l.bankName, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(
                      '${l.amount} som • ${l.months} months • ${l.rate.toStringAsFixed(0)}%\nMonthly: ${l.monthlyPayment} som',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      onPressed: () => LoansService.removeAt(i),
                      icon: Icon(Icons.delete_outline, color: cs.secondary),
                    ),
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
