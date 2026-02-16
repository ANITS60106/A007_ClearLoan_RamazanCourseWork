import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/app_settings.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: cs.primary.withOpacity(0.2),
                        child: Text(
                          user?.fullName.isNotEmpty == true ? user!.fullName[0] : 'U',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.fullName ?? 'Demo User',
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.phone ?? '+996 ...',
                              style: TextStyle(color: Colors.white.withOpacity(0.7)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('Passport ID'),
                  subtitle: Text(
                    user?.passportId.isNotEmpty == true ? user!.passportId : 'Not provided',
                    style: TextStyle(color: Colors.white.withOpacity(0.75)),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.work_outline),
                  title: const Text('Workplace'),
                  subtitle: Text(
                    user?.workplace.isNotEmpty == true ? user!.workplace : 'Not provided',
                    style: TextStyle(color: Colors.white.withOpacity(0.75)),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(width: 10),
                          const Text('Language'),
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: AppSettings.language,
                        builder: (context, lang, _) {
                          return Row(
                            children: [
                              Text(lang == 'ru' ? 'Русский' : 'Кыргызча'),
                              const SizedBox(width: 8),
                              Switch(
                                value: lang == 'ky',
                                activeColor: cs.primary,
                                onChanged: (v) {
                                  // Prototype switcher. Real localization can be added later.
                                  AppSettings.language.value = v ? 'ky' : 'ru';
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton.icon(
                icon: Icon(Icons.logout, color: cs.secondary),
                label: const Text('Logout'),
                onPressed: () {
                  AuthService.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (_) => false,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Language switcher is a prototype (UI only).',
                style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
