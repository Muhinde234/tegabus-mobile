import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/utils/colors.dart';

/// Open the same searchable city-picker bottom sheet used by [DropdownRow].
/// Returns the selected city or `null` if dismissed. Exposed so other screens
/// (like CompanySchedulesScreen) can offer the exact same UX without
/// duplicating the sheet markup.
Future<String?> showCityPicker(
  BuildContext context, {
  required String title,
  required List<String> items,
  String? selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) =>
        _CityPickerSheet(title: title, items: items, selected: selected),
  );
}

/// A single From/To selector cell. Shows a colored origin/destination dot,
/// a small label ("From" / "To"), and the chosen city below it. Tap opens
/// a bottom-sheet picker with the full list of options — much friendlier on
/// mobile than the stock DropdownButtonFormField overlay.
class DropdownRow extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  /// Visual hint: `true` = origin (outlined dot), `false` = destination
  /// (filled dot). Lets the From/To pair read like a route on a map.
  final bool isOrigin;

  const DropdownRow({
    super.key,
    required this.label,
    this.value,
    required this.onChanged,
    required this.items,
    this.isOrigin = true,
  });

  Future<void> _openPicker(BuildContext context) async {
    final selected = await showCityPicker(
      context,
      title: label,
      items: items,
      selected: value,
    );
    if (selected != null) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openPicker(context),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Route dot — outlined for origin, filled for destination.
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOrigin ? Colors.transparent : DColors.primary,
                border: isOrigin
                    ? Border.all(color: DColors.primary, width: 2.5)
                    : null,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: DColors.neutral4,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value ?? 'Select city',
                    style: TextStyle(
                      color:
                          value == null ? DColors.neutral4 : DColors.neutral6,
                      fontSize: 16,
                      fontWeight: value == null
                          ? FontWeight.w500
                          : FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_down_1,
                size: 16, color: DColors.neutral4),
          ],
        ),
      ),
    );
  }
}

class _CityPickerSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selected;

  const _CityPickerSheet({
    required this.title,
    required this.items,
    required this.selected,
  });

  @override
  State<_CityPickerSheet> createState() => _CityPickerSheetState();
}

class _CityPickerSheetState extends State<_CityPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final filtered = widget.items
        .where((c) => q.isEmpty || c.toLowerCase().contains(q))
        .toList();

    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, scrollCtrl) => Column(
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: DColors.neutral2,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Iconsax.close_circle,
                        color: DColors.neutral4),
                  ),
                ],
              ),
            ),
            // Search box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search city',
                  prefixIcon: const Icon(Iconsax.search_normal, size: 18),
                  filled: true,
                  fillColor: DColors.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text('No matches',
                          style: TextStyle(color: DColors.neutral4)),
                    )
                  : ListView.builder(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final city = filtered[i];
                        final isSelected = city == widget.selected;
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Navigator.pop(context, city),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: DColors.primary1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(Iconsax.location,
                                        size: 18, color: DColors.primary),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      city,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? DColors.primary
                                            : DColors.neutral6,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(Icons.check_circle_rounded,
                                        color: DColors.primary, size: 20),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
