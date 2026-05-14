import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/screens/explore_screen.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/my_tickets.dart';
import 'package:mobile/screens/profile_screen.dart';
import 'package:mobile/utils/colors.dart';
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

    final tabs = <_NavTab>[
      _NavTab(icon: Iconsax.home_2, label: l.navHome),
      _NavTab(icon: Iconsax.ticket, label: l.navMyTickets),
      _NavTab(icon: Iconsax.search_normal, label: l.navExplore),
      _NavTab(icon: Iconsax.user, label: l.navProfile),
    ];

    return Scaffold(
      // Custom bottom nav: stock NavigationBar + Iconsax `*5` (filled) variants
      // produced near-invisible icons on the selected pill (the Profile tab in
      // particular looked empty). This pill-style nav controls the colors
      // explicitly so the active tab is unambiguous and on-brand.
      bottomNavigationBar: _BottomNav(
        tabs: tabs,
        currentIndex: _currentPageIndex,
        onTap: (i) => setState(() => _currentPageIndex = i),
      ),
      // Chat is reachable via the floating chat bubble on the Home screen
      // (Meta-AI / WhatsApp style), so it no longer needs a tab slot.
      body: IndexedStack(
        index: _currentPageIndex,
        children: const [
          HomeScreen(),
          MyTickets(),
          ExploreScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}

class _NavTab {
  final IconData icon;
  final String label;
  const _NavTab({required this.icon, required this.label});
}

class _BottomNav extends StatelessWidget {
  final List<_NavTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            // Stronger shadow on dark canvas so the bar still separates
            // visibly from the body background.
            color:
                Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          // Fixed height keeps the bar predictable; without it the items
          // could stretch into any unbounded space the Scaffold offers.
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(tabs.length, (i) {
              final tab = tabs[i];
              final selected = i == currentIndex;
              return Expanded(
                child: _NavItem(
                  icon: tab.icon,
                  label: tab.label,
                  selected: selected,
                  onTap: () => onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Classic bottom-nav layout: icon on top, label underneath. Selected tab
    // wraps the icon in a brand-tinted circle (no top accent bar) so the
    // highlight feels self-contained and on-target. Label adopts brand color
    // when selected. Inactive tabs are quiet greys.
    //
    // The brand colour comes from `context.colors.primary` so it brightens
    // in dark mode (deep green is invisible on a dark surface).
    final brand = context.colors.primary;
    final iconColor = selected ? brand : DColors.neutral4;
    final labelColor = selected ? brand : DColors.neutral4;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated circle that fades in around the icon when selected.
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Bumped alpha to 0.22 (was 0.15) — the lower value got
                // swallowed on dark surfaces and made the active pill
                // basically invisible.
                color: selected
                    ? brand.withValues(alpha: 0.22)
                    : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: labelColor,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
