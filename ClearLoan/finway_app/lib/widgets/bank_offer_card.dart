import 'package:flutter/material.dart';
import '../models/bank_offer.dart';

class BankOfferCard extends StatelessWidget {
  final BankOffer offer;

  const BankOfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (Color color, IconData icon, String label) = switch (offer.status) {
      OfferStatus.approved => (cs.primary, Icons.check_circle, 'Approved'),
      OfferStatus.alternative => (Colors.orange, Icons.flag, 'Alternative'),
      OfferStatus.rejected => (cs.secondary, Icons.cancel, 'Rejected'),
    };

    String subtitle;
    if (offer.status == OfferStatus.rejected) {
      subtitle = 'Unfortunately, you were rejected';
    } else {
      subtitle = 'Rate ${offer.rate.toStringAsFixed(0)}% • ${offer.months} months';
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.06),
          child: Text(
            offer.bankName.isNotEmpty ? offer.bankName[0] : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        title: Text(
          offer.bankName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.7))),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
