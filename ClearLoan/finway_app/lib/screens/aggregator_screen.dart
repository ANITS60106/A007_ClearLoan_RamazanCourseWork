import 'package:flutter/material.dart';
import '../data/mock_offers.dart';
import '../models/bank_offer.dart';
import '../widgets/bank_offer_card.dart';

class AggregatorScreen extends StatefulWidget {
  const AggregatorScreen({super.key});

  @override
  State<AggregatorScreen> createState() => _AggregatorScreenState();
}

class _AggregatorScreenState extends State<AggregatorScreen> {
  final _search = TextEditingController();
  int _filter = 0; // 0 all, 1 low rate, 2 short, 3 long

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<BankOffer> _applyFilters() {
    var list = List<BankOffer>.from(mockOffers);

    final q = _search.text.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((o) => o.bankName.toLowerCase().contains(q)).toList();
    }

    if (_filter == 1) {
      list = list.where((o) => o.status != OfferStatus.rejected && o.rate <= 20).toList();
    } else if (_filter == 2) {
      list = list.where((o) => o.status != OfferStatus.rejected && o.months <= 24).toList();
    } else if (_filter == 3) {
      list = list.where((o) => o.status != OfferStatus.rejected && o.months >= 36).toList();
    }

    // show approved first, then alternative, then rejected
    list.sort((a, b) => a.status.index.compareTo(b.status.index));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final offers = _applyFilters();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggregator'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Most likely to approve',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _search,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search by bank',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _search.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _chip('All', 0, cs),
                        const SizedBox(width: 8),
                        _chip('Low %', 1, cs),
                        const SizedBox(width: 8),
                        _chip('Short term', 2, cs),
                        const SizedBox(width: 8),
                        _chip('Long term', 3, cs),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (_, i) => BankOfferCard(offer: offers[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, int value, ColorScheme cs) {
    final selected = _filter == value;
    return ChoiceChip(
      label: Text(text),
      selected: selected,
      onSelected: (_) => setState(() => _filter = value),
      selectedColor: cs.primary.withOpacity(0.2),
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.white70),
      side: BorderSide(color: selected ? cs.primary.withOpacity(0.35) : Colors.white12),
    );
  }
}
