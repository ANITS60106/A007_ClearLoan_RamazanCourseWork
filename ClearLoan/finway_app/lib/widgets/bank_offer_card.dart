import 'package:flutter/material.dart';
import '../models/bank_offer.dart';
import '../services/i18n.dart';
import 'app_card.dart';

class BankOfferCard extends StatelessWidget {
  final BankOffer offer;

  const BankOfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (Color color, IconData icon, String label) = switch (offer.status) {
      OfferStatus.approved => (cs.primary, Icons.check_circle, I18n.t('approved')),
      OfferStatus.alternative => (Colors.orange, Icons.flag, I18n.t('alternative')),
      OfferStatus.rejected => (cs.error, Icons.cancel, I18n.t('rejected')),
    };

    final subtitle = offer.status == OfferStatus.rejected
        ? 'Unfortunately, you were rejected'
        : 'Rate ${offer.rate.toStringAsFixed(0)}% • ${offer.months} months';

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 220),
      tween: Tween(begin: 0.96, end: 1),
      curve: Curves.easeOut,
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: AppCard(
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: cs.primary.withOpacity(0.12),
              child: Text(
                offer.bankName.isNotEmpty ? offer.bankName[0] : '?',
                style: TextStyle(color: cs.primary, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer.bankName, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.black.withOpacity(0.55))),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
