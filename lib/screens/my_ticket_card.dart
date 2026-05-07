import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/screens/ticket_detail_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/dashed_line.dart';
import 'package:mobile/widgets/ticket_clipper.dart';

class MyTicketCard extends StatelessWidget {
  final Ticket ticket;

  const MyTicketCard({super.key, required this.ticket});

  bool get _isUpcoming => ticket.departureTime.isAfter(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dep = DateFormat('h:mm a').format(ticket.departureTime);
    final arr = DateFormat('h:mm a').format(ticket.arrivalTime);
    final date = DateFormat('EEE, MMM d yyyy').format(ticket.departureTime);
    final dur = ticket.arrivalTime.difference(ticket.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    final company = DummyCompanies.byId(
      MyTicketsNotifier.companyIdForTicket(ticket.id),
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketDetailScreen(ticket: ticket),
        ),
      ),
      child: ClipPath(
        clipper: TicketClipper(notchRadius: 18, notchPosition: 0.58),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: DColors.cardShadow,
          ),
          child: Column(
            children: [
              // ── Top section: Route info ──
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                child: Column(
                  children: [
                    // Header row
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
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              height: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(company.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14)),
                              const SizedBox(height: 1),
                              Text(
                                '$date  •  ${l.seatLabel(ticket.seatNumber)}',
                                style: const TextStyle(
                                    color: DColors.neutral4, fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        _StatusBadge(isUpcoming: _isUpcoming),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Route visualization
                    Row(
                      children: [
                        // Origin
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dep,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: DColors.neutral6)),
                              const SizedBox(height: 2),
                              Text(ticket.origin,
                                  style: const TextStyle(
                                      color: DColors.neutral5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ],
                          ),
                        ),

                        // Duration line
                        Expanded(
                          child: Column(
                            children: [
                              Text(durationText,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: DColors.neutral4,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: DColors.primary, width: 2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      color: DColors.primary3,
                                    ),
                                  ),
                                  const Icon(Iconsax.bus, size: 14, color: DColors.primary),
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      color: DColors.primary3,
                                    ),
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
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
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: DColors.neutral6)),
                              const SizedBox(height: 2),
                              Text(ticket.destination,
                                  style: const TextStyle(
                                      color: DColors.neutral5,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Dashed separator ──
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: DashedLine(color: DColors.neutral2),
              ),

              // ── Bottom section: QR hint ──
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: DColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Iconsax.scan_barcode, size: 16, color: DColors.primary),
                    ),
                    const SizedBox(width: 10),
                    Text(l.tapToViewQr,
                        style: const TextStyle(
                            color: DColors.neutral4,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    const Icon(Iconsax.arrow_right_3, size: 16, color: DColors.neutral3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isUpcoming;
  const _StatusBadge({required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isUpcoming ? DColors.success1 : DColors.neutral1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUpcoming ? DColors.success6 : DColors.neutral4,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            isUpcoming ? 'Upcoming' : 'Completed',
            style: TextStyle(
              color: isUpcoming ? DColors.success6 : DColors.neutral4,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
