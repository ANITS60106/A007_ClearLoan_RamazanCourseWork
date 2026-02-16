import 'package:flutter/material.dart';
import '../services/loans_service.dart';
import '../models/active_loan.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _amount = TextEditingController(text: '50000');
  final _months = TextEditingController(text: '36');
  final _purpose = TextEditingController(text: 'Ремонт квартиры');

  int get _amountVal => int.tryParse(_amount.text.replaceAll(' ', '')) ?? 0;
  int get _monthsVal => int.tryParse(_months.text) ?? 0;

  int _monthlyPayment() {
    if (_monthsVal <= 0) return 0;
    return (_amountVal / _monthsVal).round();
  }

  @override
  void dispose() {
    _amount.dispose();
    _months.dispose();
    _purpose.dispose();
    super.dispose();
  }

  void _submit() {
    final amount = _amountVal;
    final months = _monthsVal;

    if (amount <= 0 || months <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid amount and term')),
      );
      return;
    }

    // Prototype: add "requested loan" as an active loan with a demo bank.
    LoansService.addLoan(
      ActiveLoan(
        bankName: 'Demo Bank',
        amount: amount,
        months: months,
        rate: 22,
        monthlyPayment: _monthlyPayment(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted (prototype). Check "Loans" tab.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Request')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Loan request',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your desired terms. This is a prototype form.',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Loan amount (som)',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _months,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Term (months)',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _purpose,
              decoration: const InputDecoration(
                labelText: 'Purpose (optional)',
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated monthly payment',
                      style: TextStyle(color: Colors.white.withOpacity(0.75)),
                    ),
                    Text(
                      '${_monthlyPayment()} som',
                      style: TextStyle(color: cs.primary, fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit request'),
            ),
          ],
        ),
      ),
    );
  }
}
