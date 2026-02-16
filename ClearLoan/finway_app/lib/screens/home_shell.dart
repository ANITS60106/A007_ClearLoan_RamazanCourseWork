import 'package:flutter/material.dart';
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
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF12151B),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: cs.primary,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Aggregator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Loans',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_rounded),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
