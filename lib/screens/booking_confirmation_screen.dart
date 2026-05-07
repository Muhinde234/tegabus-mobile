import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/screens/layout.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/dashed_line.dart';
import 'package:mobile/widgets/ticket_clipper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final BuyTicketResponse booking;

  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final b = widget.booking;
    final dep = DateFormat('EEE, MMM d • h:mm a').format(b.departureTime);
    final arr = DateFormat('h:mm a').format(b.arrivalTime);
    final shortRef = b.id.length > 8
        ? b.id.substring(0, 8).toUpperCase()
        : b.id.toUpperCase();
    final company = DummyCompanies.byId(
      MyTicketsNotifier.companyIdForTicket(b.id),
    );

    return Scaffold(
      backgroundColor: DColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // ── Success animation ──
              ScaleTransition(
                scale: _pulseAnim,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        DColors.success6,
                        DColors.success6.withValues(alpha: 0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: DColors.success6.withValues(alpha: 0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded,
                      color: Colors.white, size: 48),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                l.bookingConfirmed,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
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

              // ── Ticket card with notch ──
              ClipPath(
                clipper: TicketClipper(notchRadius: 20, notchPosition: 0.48),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: DColors.elevatedShadow,
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          gradient: DColors.primaryGradient,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    b.fullName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    l.seatLabel(b.seatNumber),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // ── Operating company chip ──
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(6, 4, 12, 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
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
                                          fontSize: 11,
                                          color: company.brandColor,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      company.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(b.origin,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                      const SizedBox(height: 2),
                                      Text(dep,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.7),
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Iconsax.bus,
                                      color: Colors.white, size: 16),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(b.destination,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18)),
                                      const SizedBox(height: 2),
                                      Text(arr,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.7),
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Dashed separator
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        child: DashedLine(color: DColors.neutral2),
                      ),

                      // QR Code section
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              l.scanToVerify,
                              style: const TextStyle(
                                  color: DColors.neutral4, fontSize: 12),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: DColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: b.qrCodeUrl.isNotEmpty
                                  ? Image.network(
                                      b.qrCodeUrl,
                                      width: 160,
                                      height: 160,
                                      errorBuilder: (_, __, ___) =>
                                          _buildQrFallback(b.id),
                                    )
                                  : _buildQrFallback(b.id),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              l.bookingRef(shortRef),
                              style: const TextStyle(
                                color: DColors.neutral5,
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Actions ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: DColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: DColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Layout()),
                    (_) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Iconsax.home, size: 18),
                  label: Text(l.goToHome),
                ),
              ),

              const SizedBox(height: 12),
              OutlinedButton.icon(
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
                icon: const Icon(Iconsax.ticket, size: 18),
                label: Text(l.viewMyTickets),
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
