import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/responses/company.dart';
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
    final company =
        CompanyCache.byId(schedule.companyId) ?? CompanyCache.fallback();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ScheduleDetailsScreen(schedule: schedule),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: context.colors.softShadow,
        ),
        child: Row(
          children: [
            // ── Left accent bar ──
            Container(
              width: 4,
              height: 120,
              decoration: BoxDecoration(
                color: isLow
                    ? context.colors.danger6
                    : context.colors.primary,
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
                                  style: TextStyle(
                                      color: context.colors.neutral4, fontSize: 11)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(priceText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: context.colors.primary)),
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
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: context.colors.neutral4,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: context.colors.primary,
                                          width: 1.5),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: context.colors.primary3,
                                    ),
                                  ),
                                  Icon(Iconsax.bus,
                                      size: 12,
                                      color: context.colors.primary),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: context.colors.primary3,
                                    ),
                                  ),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colors.primary,
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
