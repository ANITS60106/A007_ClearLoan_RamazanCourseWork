import 'package:flutter/material.dart';
import '../services/app_settings.dart';
import '../services/i18n.dart';
import 'aggregator_screen.dart';
import 'loans_screen.dart';
import 'request_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [
    AggregatorScreen(),
    LoansScreen(),
    RequestScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Listen to language changes so navbar updates instantly without navigation.
    return ValueListenableBuilder<String>(
      valueListenable: AppSettings.language,
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(I18n.t('app_name')),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                tooltip: 'Language',
                onSelected: (v) => AppSettings.setLanguage(v),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'en', child: Text('English')),
                  PopupMenuItem(value: 'ru', child: Text('Русский')),
                  PopupMenuItem(value: 'ky', child: Text('Кыргызча')),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(child: Text(I18n.langLabel(AppSettings.language.value), style: const TextStyle(fontWeight: FontWeight.w800))),
                ),
              ),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: AppSettings.themeMode,
                builder: (_, mode, __) {
                  return IconButton(
                    tooltip: 'Theme',
                    onPressed: () {
                      AppSettings.setThemeMode(mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
                    },
                    icon: Icon(mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
                  );
                },
              ),
            ],
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: KeyedSubtree(
              key: ValueKey('${_index}_${AppSettings.language.value}'),
              child: _pages[_index],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.grid_view_rounded),
                label: I18n.t('aggregator'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_bag_outlined),
                label: I18n.t('loans'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.edit_note_rounded),
                label: I18n.t('request'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                label: I18n.t('profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}
