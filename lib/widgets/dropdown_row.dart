import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/utils/colors.dart';

class DropdownRow extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  const DropdownRow({
    super.key,
    required this.label,
    this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Iconsax.location, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Theme(
              data: Theme.of(context)
                  .copyWith(inputDecorationTheme: const InputDecorationTheme()),
              child: DropdownButtonFormField<String>(
                value: value,
                hint: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 14, color: DColors.neutral4),
                ),
                decoration: InputDecoration(
                  labelText: label,
                  filled: true,
                  fillColor: DColors.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: DColors.primary, width: 2),
                  ),
                ),
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item,
                        style: const TextStyle(
                            fontSize: 14, color: DColors.neutral6)),
                  );
                }).toList(),
                onChanged: onChanged,
                validator: (val) =>
                    val == null ? 'Please select $label' : null,
                dropdownColor: Colors.white,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down,
                    color: DColors.neutral5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
