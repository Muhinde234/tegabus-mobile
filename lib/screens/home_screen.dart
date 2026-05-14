import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/atoms/home_search.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/screens/chatbot_screen.dart';
import 'package:mobile/screens/company_schedules_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final ticketState = ref.watch(myTicketsNotifierProvider);
    final companiesState = ref.watch(companiesNotifierProvider);
    final recentTickets = ticketState.data?.data ?? [];

    // Auto-load tickets so the recent-trips strip is populated as soon as the
    // user lands on Home (rather than only after visiting the My Tickets tab).
    if (ticketState.isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(myTicketsNotifierProvider.notifier).fetchMyTickets();
      });
    }

    return Scaffold(
      // Floating chatbot bubble (Meta-AI / WhatsApp style). Opens the existing
      // ChatbotScreen so the assistant is reachable from anywhere on Home
      // without taking a tab slot in the bottom nav.
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: DColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: DColors.primary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatbotScreen()),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Iconsax.message_programming,
                  color: Colors.white, size: 24),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // ── Sticky Header ──
          // Pinned so it stays at the top when the user scrolls the page
          // contents. Flat bottom (no rounded corners) and a generous height
          // so the greeting and notification bell are always comfortably
          // spaced from the status bar.
          SliverPersistentHeader(
            pinned: true,
            delegate: _HomeHeaderDelegate(
              greeting: _greeting(),
              subtitle: l.whereAreYouGoing,
              notificationsTooltip: l.notifications,
              topInset: MediaQuery.of(context).padding.top,
            ),
          ),

          // ── Body Content ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search Card ──
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: context.colors.elevatedShadow,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const HomeSearch(),
                  ),

                  const SizedBox(height: 16),

                  // ── Bus Companies ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l.companiesTitle,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                      Text(l.seeAll,
                          style: TextStyle(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 132,
                    child: () {
                      if (companiesState.isInit ||
                          companiesState.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2.5, color: DColors.primary),
                        );
                      }
                      final companies = companiesState.data ?? const <Company>[];
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: companies.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, i) => _CompanyChip(
                          company: companies[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CompanySchedulesScreen(
                                  company: companies[i]),
                            ),
                          ),
                        ),
                      );
                    }(),
                  ),

                  const SizedBox(height: 28),

                  // ── Recent Trips ──
                  if (recentTickets.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l.recentTrips,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                        Text(l.seeAll,
                            style: TextStyle(
                                color: context.colors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...recentTickets.take(2).map(
                      (ticket) => _RecentTripCard(ticket: ticket),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Why TegaBus ──
                  Text(
                    l.whyTegaBus,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _FeatureTile(
                          icon: Iconsax.shield_tick,
                          label: l.safeAndSecure,
                          color: context.colors.primary,
                          bgColor: context.colors.primary1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _FeatureTile(
                          icon: Iconsax.flash_1,
                          label: l.instantBooking,
                          color: context.colors.warning6,
                          bgColor: context.colors.warning1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _FeatureTile(
                          icon: Iconsax.scan_barcode,
                          label: l.digitalTicket,
                          color: context.colors.success6,
                          bgColor: context.colors.success1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Company chip ────────────────────────────────────────────────────────────
class _CompanyChip extends StatelessWidget {
  final Company company;
  final VoidCallback onTap;
  const _CompanyChip({required this.company, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: context.colors.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _CompanyAvatar(
                    color: company.brandColor,
                    letter: company.logoLetter,
                    size: 40),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.star_1,
                          size: 12, color: Color(0xFFF5A623)),
                      const SizedBox(width: 3),
                      Text(company.rating.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              company.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            SizedBox(height: 2),
            Text(
              company.tagline,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: context.colors.neutral4,
                  fontSize: 11,
                  height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Feature tile ────────────────────────────────────────────────────────────
class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  const _FeatureTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: context.colors.softShadow,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Recent trip card ────────────────────────────────────────────────────────
class _RecentTripCard extends StatelessWidget {
  final dynamic ticket;
  const _RecentTripCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final dep = DateFormat('MMM d • h:mm a').format(ticket.departureTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: context.colors.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.primary1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Iconsax.bus,
                color: context.colors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ticket.origin} → ${ticket.destination}',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                SizedBox(height: 2),
                Text(dep,
                    style: TextStyle(color: context.colors.neutral4, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: DColors.success1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Done',
                style: TextStyle(
                    color: DColors.success6,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// ── Company avatar (WhatsApp-style circle) ─────────────────────────────────
// A round brand-coloured badge with the company's initial centred. The
// `height: 1.0` on the TextStyle collapses Flutter's default line-height
// padding so the letter sits at the optical centre instead of slightly above
// it. Reused on Home, schedules screens, and ticket cards.
class _CompanyAvatar extends StatelessWidget {
  final Color color;
  final String letter;
  final double size;
  const _CompanyAvatar({
    required this.color,
    required this.letter,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        letter,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: size * 0.46,
          height: 1.0, // <- removes default line-height padding
        ),
      ),
    );
  }
}

// ── Sticky Home header ─────────────────────────────────────────────────────
// SliverPersistentHeaderDelegate keeps the green greeting bar pinned at the
// top of the page. Fixed height so layout is stable and the header doesn't
// collapse on scroll.
class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String greeting;
  final String subtitle;
  final String notificationsTooltip;
  final double topInset;

  _HomeHeaderDelegate({
    required this.greeting,
    required this.subtitle,
    required this.notificationsTooltip,
    required this.topInset,
  });

  static const double _contentHeight = 96;

  @override
  double get minExtent => topInset + _contentHeight;

  @override
  double get maxExtent => topInset + _contentHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(gradient: DColors.primaryGradient),
      padding: EdgeInsets.only(top: topInset),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white.withValues(alpha: 0.15),
                child: const Icon(Iconsax.user, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$greeting 👋',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.notification,
                    color: Colors.white, size: 22),
                tooltip: notificationsTooltip,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_HomeHeaderDelegate old) =>
      greeting != old.greeting ||
      subtitle != old.subtitle ||
      notificationsTooltip != old.notificationsTooltip ||
      topInset != old.topInset;
}
