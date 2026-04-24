import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/screens/chatbot_screen.dart';
import 'package:mobile/screens/explore_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/my_tickets.dart';
import 'package:mobile/screens/profile_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int idx) =>
            setState(() => _currentPageIndex = idx),
        destinations: const [
          NavigationDestination(
              icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.ticket), label: 'My Tickets'),
          NavigationDestination(
              icon: Icon(Iconsax.search_normal), label: 'Explore'),
          NavigationDestination(
              icon: Icon(Iconsax.message), label: 'Chat'),
          NavigationDestination(
              icon: Icon(Iconsax.user), label: 'Profile'),
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
