import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _HomeSearchState extends ConsumerState<HomeSearch> {
  final _formKey = GlobalKey<FormState>();
  String? _from;
  String? _to;
  DateTime? _date;

  void _swap() => setState(() {
        final tmp = _from;
        _from = _to;
        _to = tmp;
      });

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
          child: CircularProgressIndicator(),
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
        Container(
          decoration: BoxDecoration(
            color: DColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownRow(
                      label: l.fromLabel,
                      value: _from,
                      onChanged: (v) => setState(() => _from = v),
                      items: origins,
                    ),
                    const Divider(height: 1, color: DColors.neutral2),
                    DropdownRow(
                      label: l.toLabel,
                      value: _to,
                      onChanged: (v) => setState(() => _to = v),
                      items: destinations,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _swap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: DColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.swap_vert,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        DateTimePicker(
          hint: l.selectDate,
          onDateTimeSelected: (dt) => setState(() => _date = dt),
        ),
        const SizedBox(height: 12),

        ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                _from != null &&
                _to != null &&
                _date != null) {
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
              ));
            }
          },
          icon: const Icon(Icons.search),
          label: Text(l.searchBuses),
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
              color: DColors.danger6.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.wifi_off_rounded,
                size: 36, color: DColors.danger6),
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
