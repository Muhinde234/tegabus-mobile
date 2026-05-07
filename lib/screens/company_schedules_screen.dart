import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/dropdown_row.dart';
import 'package:mobile/widgets/shimmers/ticket_card_shimmer.dart';
import 'package:mobile/widgets/ticket_card.dart';

class CompanySchedulesScreen extends ConsumerStatefulWidget {
  final Company company;
  const CompanySchedulesScreen({super.key, required this.company});

  @override
  ConsumerState<CompanySchedulesScreen> createState() =>
      _CompanySchedulesScreenState();
}

class _CompanySchedulesScreenState
    extends ConsumerState<CompanySchedulesScreen> {
  String? _from;
  String? _to;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refetch();
    });
  }

  void _refetch() {
    ref.read(schedulesNotifierProvider.notifier).fetchSchedules(
          companyId: widget.company.id,
          from: _from,
          to: _to,
        );
  }

  Future<void> _pickFrom(List<String> origins) async {
    final picked = await showCityPicker(
      context,
      title: 'From',
      items: origins,
      selected: _from,
    );
    if (picked == null) return;
    setState(() => _from = picked);
    _refetch();
  }

  Future<void> _pickTo(List<String> destinations) async {
    final picked = await showCityPicker(
      context,
      title: 'To',
      items: destinations,
      selected: _to,
    );
    if (picked == null) return;
    setState(() => _to = picked);
    _refetch();
  }

  void _clearRouteFilter() {
    if (_from == null && _to == null) return;
    setState(() {
      _from = null;
      _to = null;
    });
    _refetch();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final state = ref.watch(schedulesNotifierProvider);
    final originsState = ref.watch(originsNotifierProvider);
    final destinationsState = ref.watch(destinationsNotifierProvider);
    final c = widget.company;

    return Scaffold(
      backgroundColor: DColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Branded header ──
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: c.brandColor,
            surfaceTintColor: c.brandColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Iconsax.arrow_left_2,
                    color: Colors.white, size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [c.brandColor, c.brandColor.withValues(alpha: 0.8)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                c.logoLetter,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: c.brandColor,
                                  height: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 2),
                                  Text(c.tagline,
                                      style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.85),
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _StatChip(
                              icon: Iconsax.star_1,
                              label: c.rating.toStringAsFixed(1),
                            ),
                            const SizedBox(width: 8),
                            _StatChip(
                              icon: Iconsax.routing,
                              label: l.routesCount(c.routesCount),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Route filter (From / To) ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: _RoutePill(
                      label: 'From',
                      value: _from,
                      onTap: () => _pickFrom(originsState.data ?? const []),
                      onClear: _from == null
                          ? null
                          : () {
                              setState(() => _from = null);
                              _refetch();
                            },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Iconsax.arrow_right_3,
                        size: 16, color: DColors.neutral4),
                  ),
                  Expanded(
                    child: _RoutePill(
                      label: 'To',
                      value: _to,
                      onTap: () =>
                          _pickTo(destinationsState.data ?? const []),
                      onClear: _to == null
                          ? null
                          : () {
                              setState(() => _to = null);
                              _refetch();
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_from != null || _to != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _clearRouteFilter,
                    icon: const Icon(Iconsax.close_circle, size: 14),
                    label: const Text('Clear filter'),
                    style: TextButton.styleFrom(
                      foregroundColor: DColors.danger6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              ),
            ),

          // ── Schedule list ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            sliver: () {
              if (state.isInit || state.isLoading) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, __) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: TicketCardShimmer(),
                    ),
                    childCount: 4,
                  ),
                );
              }
              if (state.isError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Text('${state.error}',
                          style: const TextStyle(color: DColors.neutral4)),
                    ),
                  ),
                );
              }
              final schedules = state.data ?? [];
              if (schedules.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: DColors.primary1,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Iconsax.bus,
                              size: 40, color: DColors.primary3),
                        ),
                        const SizedBox(height: 14),
                        Text(l.noSchedulesForCompany,
                            style: const TextStyle(
                                color: DColors.neutral4,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TicketCard(schedule: schedules[i]),
                  ),
                  childCount: schedules.length,
                ),
              );
            }(),
          ),
        ],
      ),
    );
  }
}

/// Compact "From / To" pill used as a route filter on this screen. Shows the
/// label on top and the chosen city below; tap opens the city picker, and a
/// small × clears the value when one is set.
class _RoutePill extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _RoutePill({
    required this.label,
    required this.value,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isSet = value != null;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSet ? DColors.primary : DColors.neutral2,
              width: isSet ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: DColors.neutral4,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value ?? 'Any city',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSet ? FontWeight.w800 : FontWeight.w500,
                        color:
                            isSet ? DColors.neutral6 : DColors.neutral4,
                      ),
                    ),
                  ],
                ),
              ),
              if (onClear != null)
                GestureDetector(
                  onTap: onClear,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Iconsax.close_circle,
                        size: 18, color: DColors.neutral4),
                  ),
                )
              else
                const Icon(Iconsax.arrow_down_1,
                    size: 14, color: DColors.neutral4),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ],
      ),
    );
  }
}
