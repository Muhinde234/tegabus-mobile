import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/colors.dart';

class DateTimePicker extends StatefulWidget {
  final String hint;
  final ValueChanged<DateTime> onDateTimeSelected;

  const DateTimePicker({
    super.key,
    required this.hint,
    required this.onDateTimeSelected,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;
    if (!context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => _selectedDateTime = dateTime);
    widget.onDateTimeSelected(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final isSet = _selectedDateTime != null;
    final formatted = isSet
        ? DateFormat('EEE, MMM d • h:mm a').format(_selectedDateTime!)
        : widget.hint;

    return InkWell(
      onTap: () => _pickDateTime(context),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: context.colors.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colors.primary1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Iconsax.calendar_1,
                  size: 18, color: context.colors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DEPARTURE',
                    style: TextStyle(
                      color: context.colors.neutral4,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatted,
                    style: TextStyle(
                      color: isSet
                          ? context.colors.neutral6
                          : context.colors.neutral4,
                      fontSize: 14,
                      fontWeight:
                          isSet ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Iconsax.arrow_down_1,
                size: 16, color: context.colors.neutral4),
          ],
        ),
      ),
    );
  }
}
