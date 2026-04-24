import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/atoms/home_search.dart';
import 'package:mobile/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: DColors.primary,
            surfaceTintColor: DColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0B3B2E), Color(0xFF1A6B52)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good day! 👋',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.notification,
                      color: Colors.white, size: 22),
                  tooltip: 'Notifications',
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const HomeSearch(),
                  ),

                  const SizedBox(height: 28),

                  // Quick routes section
                  const Text(
                    'Popular Routes',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 88,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _RouteChip('Kigali', 'Musanze', '2h 30m'),
                        _RouteChip('Kigali', 'Huye', '2h 30m'),
                        _RouteChip('Kigali', 'Rubavu', '3h'),
                        _RouteChip('Kigali', 'Rusizi', '5h'),
                        _RouteChip('Musanze', 'Rubavu', '1h 30m'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Features section
                  const Text(
                    'Why TegaBus?',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: _FeatureTile(
                          icon: Icons.verified_outlined,
                          label: 'Safe & Secure',
                          color: DColors.primary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _FeatureTile(
                          icon: Icons.bolt_outlined,
                          label: 'Instant Booking',
                          color: DColors.warning6,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _FeatureTile(
                          icon: Icons.qr_code_outlined,
                          label: 'Digital Ticket',
                          color: DColors.success6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteChip extends StatelessWidget {
  final String from;
  final String to;
  final String duration;
  const _RouteChip(this.from, this.to, this.duration);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DColors.neutral2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(from,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13)),
              ),
              const Icon(Icons.arrow_forward,
                  size: 12, color: DColors.neutral3),
              Expanded(
                child: Text(to,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13)),
              ),
            ],
          ),
          Text(duration,
              style: const TextStyle(
                  color: DColors.neutral4, fontSize: 11)),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _FeatureTile(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DColors.neutral2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
