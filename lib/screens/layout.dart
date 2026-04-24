import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/screens/chatbot_screen.dart';
import 'package:mobile/screens/explore_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/my_tickets.dart';
import 'package:mobile/screens/profile_screen.dart';
import 'package:mobile/utils/extensions.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int idx) =>
            setState(() => _currentPageIndex = idx),
        destinations: [
          NavigationDestination(
              icon: const Icon(Iconsax.home), label: l.navHome),
          NavigationDestination(
              icon: const Icon(Iconsax.ticket), label: l.navMyTickets),
          NavigationDestination(
              icon: const Icon(Iconsax.search_normal), label: l.navExplore),
          NavigationDestination(
              icon: const Icon(Iconsax.message), label: l.navChat),
          NavigationDestination(
              icon: const Icon(Iconsax.user), label: l.navProfile),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: const [
          HomeScreen(),
          MyTickets(),
          ExploreScreen(),
          ChatbotScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
