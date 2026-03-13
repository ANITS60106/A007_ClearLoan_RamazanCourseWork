import 'package:flutter/material.dart';
import '../services/education_service.dart';
import '../services/i18n.dart';

class FinancialEducationScreen extends StatefulWidget {
  const FinancialEducationScreen({super.key});
  @override
  State<FinancialEducationScreen> createState() => _FinancialEducationScreenState();
}

class _FinancialEducationScreenState extends State<FinancialEducationScreen> {
  late Future<List<EducationArticle>> _future;
  @override
  void initState() {
    super.initState();
    _future = EducationService.list();
  }
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final icons = [Icons.school_outlined, Icons.shield_outlined, Icons.balance_outlined, Icons.lightbulb_outline];
    return SafeArea(child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(I18n.t('financial_literacy'), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text('2–3 short lessons about loans, credit history, and safe borrowing.', style: TextStyle(color: cs.onSurface.withOpacity(0.65), fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Expanded(child: FutureBuilder<List<EducationArticle>>(future: _future, builder: (_, snap){
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          final items = snap.data ?? [];
          return ListView.separated(itemCount: items.length, separatorBuilder: (_, __)=>const SizedBox(height:10), itemBuilder: (_, i){
            final a = items[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: cs.outlineVariant.withOpacity(0.55))),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children:[
                Container(width: 42, height: 42, decoration: BoxDecoration(color: cs.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(14)), child: Icon(icons[i % icons.length], color: cs.primary)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text(a.title, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height:8), Text(a.body)])),
              ]),
            );
          });
        }))
      ]),
    ));
  }
}
