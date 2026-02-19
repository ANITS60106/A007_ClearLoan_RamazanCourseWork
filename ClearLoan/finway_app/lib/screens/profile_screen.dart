import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/i18n.dart';
import '../widgets/app_card.dart';
import '../widgets/lang_switcher.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.t('profile')),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(child: LangSwitcher()),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppCard(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: cs.primary.withOpacity(0.14),
                    child: Text(
                      (user?.fullName.isNotEmpty == true) ? user!.fullName[0].toUpperCase() : 'U',
                      style: TextStyle(fontWeight: FontWeight.w900, color: cs.primary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.fullName ?? 'Demo User',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.phone ?? '+996 ...',
                          style: TextStyle(color: Colors.black.withOpacity(0.55)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            AppCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _RowField(title: I18n.t('passport_id'), value: user?.passportIdMasked ?? '—'),
                  const Divider(),
                  _RowField(title: I18n.t('workplace'), value: user?.workplace.isNotEmpty == true ? user!.workplace : '—'),
                  const Divider(),
                  _RowField(title: I18n.t('occupation'), value: user?.occupation.isNotEmpty == true ? user!.occupation : '—'),
                  const Divider(),
                  _RowField(title: I18n.t('income'), value: '${user?.monthlyIncome ?? 0} сом'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              icon: Icon(Icons.logout, color: cs.error),
              label: Text(I18n.t('logout')),
              onPressed: () {
                AuthService.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RowField extends StatelessWidget {
  final String title;
  final String value;

  const _RowField({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.black.withOpacity(0.55), fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
