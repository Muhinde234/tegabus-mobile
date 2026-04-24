import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/screens/layout.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final BuyTicketResponse booking;

  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final dep = DateFormat('EEE, MMM d • h:mm a').format(booking.departureTime);
    final arr = DateFormat('h:mm a').format(booking.arrivalTime);
    final shortRef = booking.id.length > 8
        ? booking.id.substring(0, 8).toUpperCase()
        : booking.id.toUpperCase();

    return Scaffold(
      backgroundColor: DColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: DColors.success2,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: DColors.success6, size: 48),
              ),
              const SizedBox(height: 20),
              Text(
                l.bookingConfirmed,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: DColors.neutral6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.ticketBookedSuccessfully,
                style: const TextStyle(fontSize: 14, color: DColors.neutral4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: DColors.primary,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            booking.fullName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l.seatLabel(booking.seatNumber),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(booking.origin,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                const SizedBox(height: 2),
                                Text(dep,
                                    style: const TextStyle(
                                        color: DColors.neutral4,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward,
                              color: DColors.primary),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(booking.destination,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                const SizedBox(height: 2),
                                Text(arr,
                                    style: const TextStyle(
                                        color: DColors.neutral4,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1, color: DColors.neutral2),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            l.scanToVerify,
                            style: const TextStyle(
                                color: DColors.neutral4, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          booking.qrCodeUrl.isNotEmpty
                              ? Image.network(
                                  booking.qrCodeUrl,
                                  width: 160,
                                  height: 160,
                                  errorBuilder: (_, __, ___) =>
                                      _buildQrFallback(booking.id),
                                )
                              : _buildQrFallback(booking.id),
                          const SizedBox(height: 8),
                          Text(
                            l.bookingRef(shortRef),
                            style: const TextStyle(
                              color: DColors.neutral5,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Layout()),
                  (_) => false,
                ),
                child: Text(l.goToHome),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Layout()),
                  (_) => false,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DColors.primary,
                  side: const BorderSide(color: DColors.primary),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(l.viewMyTickets),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrFallback(String data) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 160,
      backgroundColor: Colors.white,
    );
  }
}
