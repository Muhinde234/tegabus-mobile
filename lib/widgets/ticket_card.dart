import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/screens/schedule_details_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';

class TicketCard extends StatelessWidget {
  final Schedule schedule;

  const TicketCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dep = DateFormat('h:mm a').format(schedule.departureTime);
    final arr = DateFormat('h:mm a').format(schedule.arrivalTime);
    final dur = schedule.arrivalTime.difference(schedule.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    final priceText =
        '${NumberFormat('#,###').format(schedule.price.toInt())} RWF';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ScheduleDetailsScreen(schedule: schedule),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: DColors.primary2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.directions_bus,
                        color: DColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      schedule.bus,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(priceText,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: DColors.primary)),
                      const SizedBox(height: 2),
                      Text(
                        l.seatsLeft(schedule.remainingSeats),
                        style: TextStyle(
                            color: schedule.remainingSeats <= 5
                                ? DColors.danger6
                                : DColors.success6,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(schedule.from,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(dep,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 13)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(durationText,
                            style: const TextStyle(
                                fontSize: 12,
                                color: DColors.neutral4,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        const Row(children: [
                          Expanded(
                              child: Divider(
                                  color: DColors.neutral2, thickness: 1)),
                          Icon(Icons.arrow_forward,
                              size: 14, color: DColors.neutral3),
                        ]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(schedule.to,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(arr,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
