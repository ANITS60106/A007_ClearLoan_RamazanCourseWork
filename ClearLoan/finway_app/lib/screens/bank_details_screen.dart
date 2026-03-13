import 'package:flutter/material.dart';
import '../models/bank_detail.dart';
import '../services/app_settings.dart';
import '../services/banks_service.dart';
import '../services/i18n.dart';
import '../services/ratings_service.dart';

class BankDetailsScreen extends StatefulWidget {
  final String code;
  const BankDetailsScreen({super.key, required this.code});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  late Future<BankDetail> _future;
  int _selectedRating = 5;

  @override
  void initState() {
    super.initState();
    _future = BanksService.getBankDetail(widget.code);
  }

  Future<void> _refresh() async {
    setState(() {
      _future = BanksService.getBankDetail(widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t('bank_info'))),
      body: FutureBuilder<BankDetail>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          if (snap.hasError || snap.data == null) {
            return Center(child: Text('Failed to load bank data', style: TextStyle(color: cs.error, fontWeight: FontWeight.w700)));
          }
          final d = snap.data!;
          final lang = AppSettings.language.value;
          String name() => lang == 'ru' ? d.bank.nameRu : lang == 'ky' ? d.bank.nameKy : d.bank.nameEn;
          String about() => lang == 'ru' ? d.bank.aboutRu : lang == 'ky' ? d.bank.aboutKy : d.bank.aboutEn;
          String hq() => lang == 'ru' ? d.bank.hqRu : lang == 'ky' ? d.bank.hqKy : d.bank.hqEn;
          String prodTitle(LoanProduct p) => lang == 'ru' ? p.titleRu : lang == 'ky' ? p.titleKy : p.titleEn;
          String prodDesc(LoanProduct p) => lang == 'ru' ? p.descRu : lang == 'ky' ? p.descKy : p.descEn;
          String branchAddr(BankBranch b) => lang == 'ru' ? b.addressRu : lang == 'ky' ? b.addressKy : b.addressEn;

          return DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(name(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Row(children: [Icon(Icons.star, color: Colors.amber.shade700), const SizedBox(width: 6), Text('${d.avgRating.toStringAsFixed(1)} (${d.ratingCount})')]),
                    const SizedBox(height: 8),
                    Text(hq(), style: TextStyle(color: cs.onSurface.withOpacity(0.7))),
                  ]),
                ),
                const TabBar(tabs: [Tab(text: 'About'), Tab(text: 'Products'), Tab(text: 'Branches'), Tab(text: 'Rating')]),
                Expanded(
                  child: TabBarView(children: [
                    ListView(padding: const EdgeInsets.all(16), children: [Text(about())]),
                    ListView(padding: const EdgeInsets.all(16), children: d.products.map((p) => _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(prodTitle(p), style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text('${p.rateFrom.toStringAsFixed(1)}% - ${p.rateTo.toStringAsFixed(1)}% • ${p.minMonths}-${p.maxMonths}m • ${p.minAmount}-${p.maxAmount} KGS', style: TextStyle(color: cs.onSurface.withOpacity(0.7), fontWeight: FontWeight.w700, fontSize: 12)), const SizedBox(height: 8), Text(prodDesc(p))]))).toList()),
                    ListView(padding: const EdgeInsets.all(16), children: d.branches.map((b) => _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(b.city, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 6), Text(branchAddr(b)), if (b.hours.isNotEmpty) Text(b.hours, style: TextStyle(color: cs.onSurface.withOpacity(0.6)))]))).toList()),
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text('Rate this bank', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
                        const SizedBox(height: 10),
                        Row(children: List.generate(5, (i) => IconButton(onPressed: () => setState(() => _selectedRating = i + 1), icon: Icon(i < _selectedRating ? Icons.star : Icons.star_border, color: Colors.amber.shade700)))),
                        ElevatedButton(onPressed: () async { await RatingsService.rateBank(code: widget.code, rating: _selectedRating); if (!mounted) return; ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rating saved'))); await _refresh(); }, child: const Text('Save rating')),
                        const SizedBox(height: 14),
                        ...d.ratings.map((r) => _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${'★' * r.rating}', style: TextStyle(color: Colors.amber.shade700, fontWeight: FontWeight.w900)), if (r.userName.isNotEmpty) Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w700)), if (r.comment.isNotEmpty) Text(r.comment)]))),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: cs.outlineVariant.withOpacity(0.55))), child: child);
  }
}
