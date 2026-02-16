import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullName = TextEditingController();
  final _phone = TextEditingController();
  final _passport = TextEditingController();
  final _workplace = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _obscure = true;

  @override
  void dispose() {
    _fullName.dispose();
    _phone.dispose();
    _passport.dispose();
    _workplace.dispose();
    _password.dispose();
    super.dispose();
  }

  void _doRegister() {
    final err = AuthService.register(
      phone: _phone.text,
      password: _password.text,
      passportId: _passport.text,
      fullName: _fullName.text,
      workplace: _workplace.text,
    );

    if (err != null) {
      setState(() => _error = err);
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text(
              'Create your ClearLoan account',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'Passport data is requested only during registration (prototype).',
              style: TextStyle(color: Colors.white.withOpacity(0.65)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fullName,
              decoration: const InputDecoration(
                labelText: 'Full name',
                hintText: 'Name Surname',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone number',
                hintText: '+996 ...',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passport,
              decoration: const InputDecoration(
                labelText: 'Passport ID',
                hintText: 'AN1234567',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _workplace,
              decoration: const InputDecoration(
                labelText: 'Workplace',
                hintText: 'Company / University',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: TextStyle(color: cs.secondary)),
            ],
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _doRegister,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
