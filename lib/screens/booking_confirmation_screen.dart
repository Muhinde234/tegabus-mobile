import 'package:flutter/material.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/screens/layout.dart';
import 'package:mobile/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final BuyTicketResponse booking;

  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final dep = DateFormat('EEE, MMM d • h:mm a').format(booking.departureTime);
    final arr = DateFormat('h:mm a').format(booking.arrivalTime);

    return Scaffold(
      backgroundColor: DColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              // Success icon
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
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: DColors.neutral6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your ticket has been booked successfully.',
                style: TextStyle(
                    fontSize: 14,
                    color: DColors.neutral4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Ticket card
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
                    // Green header
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
                            'Seat ${booking.seatNumber}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    // Route row
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

                    // QR Code
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Scan to verify',
                            style: TextStyle(
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
                            'Booking #${booking.id.length > 8 ? booking.id.substring(0, 8).toUpperCase() : booking.id.toUpperCase()}',
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

              // Action buttons
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Layout()),
                  (_) => false,
                ),
                child: const Text('Go to Home'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const Layout()),
                  (_) => false,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DColors.primary,
                  side: const BorderSide(color: DColors.primary),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('View My Tickets'),
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
