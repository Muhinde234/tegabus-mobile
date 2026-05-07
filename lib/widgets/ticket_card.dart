import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/api/services/ticket_schedule_service.dart';
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
    final isLow = schedule.remainingSeats <= 5;
    final company = TicketScheduleService.companyFor(schedule.id);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ScheduleDetailsScreen(schedule: schedule),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: DColors.softShadow,
        ),
        child: Row(
          children: [
            // ── Left accent bar ──
            Container(
              width: 4,
              height: 120,
              decoration: BoxDecoration(
                color: isLow ? DColors.danger6 : DColors.primary,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              ),
            ),

            // ── Card content ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
                child: Column(
                  children: [
                    // ── Company badge + price ──
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: company.brandColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            company.logoLetter,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(company.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              Text(schedule.bus,
                                  style: const TextStyle(
                                      color: DColors.neutral4, fontSize: 11)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(priceText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: DColors.primary)),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isLow ? DColors.danger1 : DColors.success1,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                l.seatsLeft(schedule.remainingSeats),
                                style: TextStyle(
                                    color: isLow ? DColors.danger6 : DColors.success6,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Route visualization ──
                    Row(
                      children: [
                        // Origin
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dep,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 16)),
                              const SizedBox(height: 2),
                              Text(schedule.from,
                                  style: const TextStyle(
                                      color: DColors.neutral5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                            ],
                          ),
                        ),

                        // Duration line
                        Expanded(
                          child: Column(
                            children: [
                              Text(durationText,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: DColors.neutral4,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: DColors.primary, width: 1.5),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: DColors.primary3,
                                    ),
                                  ),
                                  const Icon(Iconsax.bus, size: 12, color: DColors.primary),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: DColors.primary3,
                                    ),
                                  ),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: DColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Destination
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(arr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 16)),
                              const SizedBox(height: 2),
                              Text(schedule.to,
                                  style: const TextStyle(
                                      color: DColors.neutral5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
