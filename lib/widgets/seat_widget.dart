import 'package:flutter/material.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';
import 'package:mobile/utils/colors.dart';

class SeatWidget extends StatelessWidget {
  final SeatAvailability seat;
  final bool isSelected;
  final VoidCallback? onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = seat.booked
        ? DColors.neutral2
        : isSelected
            ? DColors.warning5
            : DColors.success5;

    final iconColor = seat.booked
        ? DColors.neutral3
        : isSelected
            ? DColors.warning6
            : DColors.success6;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 52,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: DColors.warning6, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_seat, size: 22, color: iconColor),
            const SizedBox(height: 2),
            Text(
              seat.seatNumber,
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: seat.booked ? DColors.neutral3 : DColors.neutral6),
            ),
          ],
        ),
      ),
    );
  }
}
