import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/screens/search_results.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/date_time_picker.dart';
import 'package:mobile/widgets/dropdown_row.dart';

class HomeSearch extends ConsumerStatefulWidget {
  const HomeSearch({super.key});

  @override
  ConsumerState<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends ConsumerState<HomeSearch>
    with SingleTickerProviderStateMixin {
  String? _from;
  String? _to;
  DateTime? _date;

  late final AnimationController _swapCtrl;

  @override
  void initState() {
    super.initState();
    _swapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _swapCtrl.dispose();
    super.dispose();
  }

  void _swap() {
    _swapCtrl.forward(from: 0);
    setState(() {
      final tmp = _from;
      _from = _to;
      _to = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final originsState = ref.watch(originsNotifierProvider);
    final destinationsState = ref.watch(destinationsNotifierProvider);

    final loading = originsState.isLoading ||
        originsState.isInit ||
        destinationsState.isLoading ||
        destinationsState.isInit;

    if (loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: DColors.primary,
          ),
        ),
      );
    }

    if (originsState.isError || destinationsState.isError) {
      return _SearchErrorState(
        onRetry: () {
          if (originsState.isError) {
            ref.read(originsNotifierProvider.notifier).fetchOrigins();
          }
          if (destinationsState.isError) {
            ref.read(destinationsNotifierProvider.notifier).fetchDestinations();
          }
        },
      );
    }

    final origins = originsState.data ?? [];
    final destinations = destinationsState.data ?? [];

    return Column(
      children: [
        // ── From / To selector ──
        // Single rounded card with two stacked cells. The swap button sits on
        // the right of the divider line so it doesn't collide with the
        // chevron on either cell. Form/validator dropped because the cells
        // are tap-to-pick (validation happens on the Search button below).
        Container(
          decoration: BoxDecoration(
            color: DColors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              DropdownRow(
                label: l.fromLabel,
                value: _from,
                onChanged: (v) => setState(() => _from = v),
                items: origins,
                isOrigin: true,
              ),
              // Divider with the swap button mounted on its right edge.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      height: 1,
                      color: DColors.neutral2.withValues(alpha: 0.7),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: _swap,
                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5).animate(
                            CurvedAnimation(
                                parent: _swapCtrl, curve: Curves.easeInOut),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: DColors.primaryGradient,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: DColors.primary
                                      .withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.swap_vert,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DropdownRow(
                label: l.toLabel,
                value: _to,
                onChanged: (v) => setState(() => _to = v),
                items: destinations,
                isOrigin: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Date picker ──
        DateTimePicker(
          hint: l.selectDate,
          onDateTimeSelected: (dt) => setState(() => _date = dt),
        ),
        const SizedBox(height: 14),

        // ── Search button ──
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: DColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: DColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              if (_from != null && _to != null && _date != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchResults(
                      from: _from!,
                      to: _to!,
                      date: _date!,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l.selectOriginDestinationDate),
                  backgroundColor: DColors.warning6,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Iconsax.search_normal, size: 18),
            label: Text(l.searchBuses),
          ),
        ),
      ],
    );
  }
}

class _SearchErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  const _SearchErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DColors.danger1,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off_rounded,
                size: 32, color: DColors.danger6),
          ),
          const SizedBox(height: 12),
          const Text(
            'Could not load routes',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 4),
          const Text(
            'Check your connection and try again.',
            style: TextStyle(color: DColors.neutral4, fontSize: 13),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Retry'),
            style: OutlinedButton.styleFrom(
              foregroundColor: DColors.primary,
              side: const BorderSide(color: DColors.primary),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
