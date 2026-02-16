import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'home_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _obscure = true;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _doLogin() {
    final err = AuthService.login(
      phone: _phone.text,
      password: _password.text,
    );
    if (err != null) {
      setState(() => _error = err);
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.1,
            colors: [
              cs.primary.withOpacity(0.25),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  'ClearLoan',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign in with phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.75)),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    hintText: 'e.g. +996 700 123 456',
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
                  onPressed: _doLogin,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Create account'),
                ),
                const Spacer(),
                Text(
                  'Prototype: no real verification yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
