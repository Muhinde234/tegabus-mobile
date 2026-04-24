import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTicketCard extends StatelessWidget {
  final Ticket ticket;

  const MyTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dep = DateFormat('h:mm a').format(ticket.departureTime);
    final arr = DateFormat('h:mm a').format(ticket.arrivalTime);
    final date = DateFormat('EEE, MMM d y').format(ticket.departureTime);
    final dur = ticket.arrivalTime.difference(ticket.departureTime);

    return GestureDetector(
      onTap: () => _showQr(context, l),
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
                    child: const Icon(Icons.confirmation_num,
                        color: DColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.seatLabel(ticket.seatNumber),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        Text(date,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: DColors.success2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(l.confirmedStatus,
                        style: const TextStyle(
                            color: DColors.success6,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
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
                        Text(ticket.origin,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        Text(dep,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 13)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.arrow_forward,
                          color: DColors.neutral3, size: 16),
                      Text(
                        '${dur.inHours}h ${dur.inMinutes % 60}m',
                        style: const TextStyle(
                            fontSize: 11, color: DColors.neutral4),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(ticket.destination,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        Text(arr,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.qr_code_2,
                      color: DColors.neutral3, size: 16),
                  const SizedBox(width: 4),
                  Text(l.tapToViewQr,
                      style: const TextStyle(
                          color: DColors.neutral4, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQr(BuildContext context, dynamic l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${ticket.origin} → ${ticket.destination}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ticket.qrCodeUrl.isNotEmpty
                ? Image.network(ticket.qrCodeUrl,
                    width: 200,
                    height: 200,
                    errorBuilder: (_, __, ___) =>
                        _buildQrFallback(ticket.id))
                : _buildQrFallback(ticket.id),
            const SizedBox(height: 8),
            Text(l.seatLabel(ticket.seatNumber),
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.close),
          )
        ],
      ),
    );
  }

  Widget _buildQrFallback(String data) {
    return QrImageView(
      data: data.isNotEmpty ? data : 'TEGABUS-TICKET',
      version: QrVersions.auto,
      size: 200,
      backgroundColor: Colors.white,
    );
  }
}
