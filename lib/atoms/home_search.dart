import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/screens/search_results.dart';
import 'package:mobile/utils/colors.dart';
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
      ));
    }

    final origins = originsState.data ?? [];
    final destinations = destinationsState.data ?? [];

    return Column(
      children: [
        // From / To card
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
                      label: 'From',
                      value: _from,
                      onChanged: (v) => setState(() => _from = v),
                      items: origins,
                    ),
                    const Divider(height: 1, color: DColors.neutral2),
                    DropdownRow(
                      label: 'To',
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

        // Date picker
        DateTimePicker(
          hint: 'Select date',
          onDateTimeSelected: (dt) => setState(() => _date = dt),
        ),
        const SizedBox(height: 12),

        // Search button
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('Please select origin, destination and date'),
                backgroundColor: DColors.warning6,
              ));
            }
          },
          icon: const Icon(Icons.search),
          label: const Text('Search Buses'),
        ),
      ],
    );
  }
}
