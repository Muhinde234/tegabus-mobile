import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/dashed_line.dart';
import 'package:mobile/widgets/ticket_clipper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dep = DateFormat('h:mm a').format(ticket.departureTime);
    final arr = DateFormat('h:mm a').format(ticket.arrivalTime);
    final date = DateFormat('EEEE, MMMM d, yyyy').format(ticket.departureTime);
    final dur = ticket.arrivalTime.difference(ticket.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    final isUpcoming = ticket.departureTime.isAfter(DateTime.now());
    final shortRef = ticket.id.length > 8
        ? ticket.id.substring(0, 8).toUpperCase()
        : ticket.id.toUpperCase();
    final company = DummyCompanies.byId(
      MyTicketsNotifier.companyIdForTicket(ticket.id),
    );

    return Scaffold(
      backgroundColor: DColors.background,
      appBar: AppBar(
        title: const Text('Ticket Details'),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: DColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Iconsax.arrow_left_2, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Main ticket card ──
            ClipPath(
              clipper: TicketClipper(notchRadius: 22, notchPosition: 0.46),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: DColors.elevatedShadow,
                ),
                child: Column(
                  children: [
                    // ── Header with gradient ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                      decoration: const BoxDecoration(
                        gradient: DColors.primaryGradient,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ticket.fullName ?? 'Passenger',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isUpcoming ? 'UPCOMING' : 'COMPLETED',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // ── Operating company ──
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    company.logoLetter,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 13,
                                      color: company.brandColor,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l.operatedBy,
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                    Text(
                                      company.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Route visualization
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dep,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22)),
                                    const SizedBox(height: 4),
                                    Text(ticket.origin,
                                        style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.7),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),

                              Column(
                                children: [
                                  Text(durationText,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white.withValues(alpha: 0.6))),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 1.5),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.white.withValues(alpha: 0.4),
                                          ),
                                        ),
                                        Icon(Iconsax.bus,
                                            size: 12,
                                            color: Colors.white.withValues(alpha: 0.7)),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.white.withValues(alpha: 0.4),
                                          ),
                                        ),
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(arr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22)),
                                    const SizedBox(height: 4),
                                    Text(ticket.destination,
                                        style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.7),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
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
                      child: SizedBox(height: 16),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: DashedLine(color: DColors.neutral2),
                    ),

                    const SizedBox(height: 8),

                    // ── Trip details ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _InfoItem(label: 'Date', value: date, icon: Iconsax.calendar_1),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _InfoItem(label: 'Seat', value: ticket.seatNumber, icon: Iconsax.user),
                          const SizedBox(width: 16),
                          _InfoItem(label: 'Booking', value: '#$shortRef', icon: Iconsax.receipt_1),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── QR Code ──
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: DColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(l.scanToVerify,
                              style: const TextStyle(
                                  color: DColors.neutral4,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ticket.qrCodeUrl.isNotEmpty
                                ? Image.network(
                                    ticket.qrCodeUrl,
                                    width: 180,
                                    height: 180,
                                    errorBuilder: (_, __, ___) =>
                                        _buildQrFallback(ticket.id),
                                  )
                                : _buildQrFallback(ticket.id),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Action buttons ──
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.share, size: 18),
                    label: const Text('Share'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: DColors.primary,
                      side: const BorderSide(color: DColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.document_download, size: 18),
                    label: const Text('Download'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQrFallback(String data) {
    return QrImageView(
      data: data.isNotEmpty ? data : 'TEGABUS-TICKET',
      version: QrVersions.auto,
      size: 180,
      backgroundColor: Colors.white,
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DColors.primary1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: DColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: DColors.neutral4,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
