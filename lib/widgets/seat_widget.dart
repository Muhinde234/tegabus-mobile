import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    final bgColor = seat.booked
        ? DColors.neutral1
        : isSelected
            ? DColors.warning1
            : DColors.success1;

    final iconColor = seat.booked
        ? DColors.neutral3
        : isSelected
            ? DColors.warning6
            : DColors.success6;

    final borderColor = seat.booked
        ? Colors.transparent
        : isSelected
            ? DColors.warning6
            : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 50,
        height: 54,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              seat.booked ? Iconsax.user : Iconsax.personalcard,
              size: 20,
              color: iconColor,
            ),
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
