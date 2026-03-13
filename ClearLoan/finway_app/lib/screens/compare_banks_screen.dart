import 'package:flutter/material.dart';
import '../services/app_settings.dart';
import '../services/i18n.dart';
import '../services/options_service.dart';

class CompareBanksScreen extends StatelessWidget {
  final List<BankOption> options;
  const CompareBanksScreen({super.key, required this.options});

  String _bankName(BankOption o) {
    final lang = AppSettings.language.value;
    if (lang == 'ru') return o.bankNameRu;
    if (lang == 'ky') return o.bankNameKy;
    return o.bankNameEn;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('compare_banks'))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: options.length.clamp(0, 8),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final o = options[i];
          final p = (o.approvalProbability * 100).toStringAsFixed(0);
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: cs.outlineVariant.withOpacity(0.55)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(_bankName(o), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: cs.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
                  child: Text('$p%', style: TextStyle(color: cs.primary, fontWeight: FontWeight.w900)),
                ),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _metric(context, 'Rate', '${o.rateFrom.toStringAsFixed(1)}%')),
                const SizedBox(width: 8),
                Expanded(child: _metric(context, I18n.t('monthly_payment'), '${o.estimatedPayment} KGS')),
              ]),
            ]),
          );
        },
      ),
    );
  }

  Widget _metric(BuildContext context, String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(color: cs.onSurface.withOpacity(0.65), fontWeight: FontWeight.w700, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
      ]),
    );
  }
}
