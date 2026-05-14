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
    final arrivalTime =
        ticket.arrivalTime ?? ticket.departureTime.add(const Duration(hours: 3));
    final dep = DateFormat('h:mm a').format(ticket.departureTime);
    final arr = DateFormat('h:mm a').format(arrivalTime);
    final date = DateFormat('EEE, MMM d yyyy').format(ticket.departureTime);
    final dur = arrivalTime.difference(ticket.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    // Resolve company from the ticket's own companyId where present, falling
    // back to the runtime cache populated by /companies. If neither is
    // available (e.g. before the cache loads) we use a neutral fallback.
    final company = CompanyCache.byId(
          ticket.companyId ??
              MyTicketsNotifier.companyIdForTicket(ticket.id),
        ) ??
        CompanyCache.fallback();

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
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: context.colors.cardShadow,
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
                              SizedBox(height: 1),
                              Text(
                                '$date  •  ${l.seatLabel(ticket.seatNumber)}',
                                style: TextStyle(
                                    color: context.colors.neutral4, fontSize: 11),
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
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: context.colors.neutral4,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: context.colors.primary,
                                          width: 2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      color: context.colors.primary3,
                                    ),
                                  ),
                                  Icon(Iconsax.bus,
                                      size: 14,
                                      color: context.colors.primary),
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      color: context.colors.primary3,
                                    ),
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
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
                        color: context.colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Iconsax.scan_barcode,
                          size: 16, color: context.colors.primary),
                    ),
                    SizedBox(width: 10),
                    Text(l.tapToViewQr,
                        style: TextStyle(
                            color: context.colors.neutral4,
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
        color: isUpcoming
            ? context.colors.success1
            : context.colors.neutral1,
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
              color: isUpcoming
                  ? context.colors.success6
                  : context.colors.neutral4,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            isUpcoming ? 'Upcoming' : 'Completed',
            style: TextStyle(
              color: isUpcoming ? DColors.success6 : context.colors.neutral4,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
