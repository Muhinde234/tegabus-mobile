import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/shimmers/ticket_card_shimmer.dart';
import 'package:mobile/widgets/ticket_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _companyId; // null == all

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(schedulesNotifierProvider);
      if (state.isInit) {
        ref.read(schedulesNotifierProvider.notifier).fetchSchedules();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  /// Apply text + company filters to whatever the schedules notifier returned.
  /// Company filtering uses the `companyId` carried on each schedule from the
  /// backend; we keep the text query client-side because the API doesn't
  /// expose a free-text search yet.
  List<Schedule> _applyFilters(List<Schedule> schedules) {
    final q = _query.trim().toLowerCase();
    return schedules.where((s) {
      if (_companyId != null && s.companyId != _companyId) {
        return false;
      }
      if (q.isEmpty) return true;
      return s.from.toLowerCase().contains(q) ||
          s.to.toLowerCase().contains(q) ||
          s.bus.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final state = ref.watch(schedulesNotifierProvider);
    final companiesState = ref.watch(companiesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.exploreRoutes),
        actions: [
          if (_query.isNotEmpty || _companyId != null)
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: DColors.danger1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  _searchCtrl.clear();
                  setState(() {
                    _query = '';
                    _companyId = null;
                  });
                },
                icon: const Icon(Iconsax.close_circle,
                    size: 18, color: DColors.danger6),
                tooltip: l.clearFilters,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // ── Search field ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: l.searchByRoute,
                prefixIcon:
                    const Icon(Iconsax.search_normal, size: 18),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Iconsax.close_circle, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: context.colors.surface,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: DColors.neutral2, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: DColors.neutral2, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: DColors.primary, width: 1.5),
                ),
              ),
            ),
          ),

          // ── Company filter chips ──
          SizedBox(
            height: 36,
            child: () {
              if (companiesState.isInit || companiesState.isLoading) {
                return const SizedBox.shrink();
              }
              final companies =
                  companiesState.data ?? const <Company>[];
              return ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CompanyFilterChip(
                    label: l.allCompanies,
                    selected: _companyId == null,
                    color: DColors.primary,
                    onTap: () => setState(() => _companyId = null),
                  ),
                  ...companies.map((c) => _CompanyFilterChip(
                        label: c.name,
                        selected: _companyId == c.id,
                        color: c.brandColor,
                        onTap: () => setState(() => _companyId = c.id),
                      )),
                ],
              );
            }(),
          ),

          const SizedBox(height: 8),

          // ── Schedule list ──
          Expanded(
            child: RefreshIndicator(
              color: DColors.primary,
              onRefresh: () => ref
                  .read(schedulesNotifierProvider.notifier)
                  .fetchSchedules(),
              child: _buildBody(context, state, ref, l),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state, WidgetRef ref,
      dynamic l) {
    if (state.isInit || state.isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => const TicketCardShimmer(),
      );
    }

    if (state.isSuccess) {
      final all = (state.data ?? const <Schedule>[]) as List<Schedule>;
      final filtered = _applyFilters(all);

      if (filtered.isEmpty) {
        return ListView(
          // Allow pull-to-refresh even with no results.
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 80),
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.colors.primary1,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.search_status,
                      size: 40, color: context.colors.primary3),
                ),
                const SizedBox(height: 16),
                Text(l.noSchedulesFound,
                    style: TextStyle(
                        color: context.colors.neutral4,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(l.tryDifferentDateOrRoute,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: context.colors.neutral4, fontSize: 13)),
              ],
            ),
          ],
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: filtered.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => TicketCard(schedule: filtered[i]),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: DColors.danger1,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wifi_off_rounded,
                  size: 40, color: DColors.danger6),
            ),
            const SizedBox(height: 20),
            const Text(
              'No connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'We couldn\'t fetch schedules.\nCheck your internet and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.neutral4, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(schedulesNotifierProvider.notifier).fetchSchedules(),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(l.retry),
            ),
          ],
        ),
      ),
    );
  }
}

/// Brand-filled pill (selected) / outlined pill (idle), trimmed down so the
/// strip stays compact and many companies fit without horizontal scroll fatigue.
class _CompanyFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const _CompanyFilterChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: selected ? color : context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? color : DColors.neutral2,
              width: 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.22),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : context.colors.neutral6,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
