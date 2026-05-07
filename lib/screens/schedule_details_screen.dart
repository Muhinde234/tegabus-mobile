import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/screens/payment_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widgets/seat_widget.dart';
import 'package:mobile/widgets/shimmers/seat_layout_shimmer.dart';

class ScheduleDetailsScreen extends ConsumerStatefulWidget {
  final Schedule schedule;

  const ScheduleDetailsScreen({super.key, required this.schedule});

  @override
  ConsumerState<ScheduleDetailsScreen> createState() =>
      _ScheduleDetailsScreenState();
}

class _ScheduleDetailsScreenState
    extends ConsumerState<ScheduleDetailsScreen> {
  int? selectedSeatId;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final seatsState =
        ref.watch(seatsNotifierProvider(widget.schedule.id));
    final s = widget.schedule;
    // Booking now happens after the user picks a payment method on the
    // PaymentScreen, so we no longer listen to buyTicketNotifier here — that
    // listener moved to PaymentScreen.

    final dep = DateFormat('h:mm a').format(s.departureTime);
    final arr = DateFormat('h:mm a').format(s.arrivalTime);
    final dur = s.arrivalTime.difference(s.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    final priceText =
        '${NumberFormat('#,###').format(s.price.toInt())} RWF';
    final dateText = DateFormat('EEE, MMM d').format(s.departureTime);

    return Scaffold(
      backgroundColor: DColors.background,
      appBar: AppBar(
        title: Text('${s.from} → ${s.to}'),
        backgroundColor: Colors.white,
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
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // ── Trip info card ──
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: DColors.primaryGradient,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: DColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Iconsax.bus, color: Colors.white, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(s.bus,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5A623).withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(priceText,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Route
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
                                    fontSize: 20)),
                            Text(s.from,
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(durationText,
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 11)),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
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
                                Container(
                                  width: 5,
                                  height: 5,
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
                                    fontSize: 20)),
                            Text(s.to,
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Date row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Iconsax.calendar_1,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.7)),
                        const SizedBox(width: 6),
                        Text(dateText,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Seat legend ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: DColors.softShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _legend(DColors.success5, l.availableSeat),
                    _legend(DColors.warning5, l.selectedSeat),
                    _legend(DColors.neutral2, l.bookedSeat),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Seat map ──
            Expanded(
              child: RefreshIndicator(
                color: DColors.primary,
                onRefresh: () => ref
                    .read(seatsNotifierProvider(widget.schedule.id).notifier)
                    .fetchSeats(),
                child: () {
                  if (seatsState.isLoading || seatsState.isInit) {
                    return const SeatLayoutShimmer();
                  }
                  if (seatsState.isError) {
                    return Center(
                        child: Text('${l.failedToLoadSeats}\n'
                            '${seatsState.error}'));
                  }
                  final seats = seatsState.data!.seats;
                  final columns = {
                    'A': seats
                        .where((s) => s.seatNumber.startsWith('A'))
                        .toList(),
                    'B': seats
                        .where((s) => s.seatNumber.startsWith('B'))
                        .toList(),
                    'C': seats
                        .where((s) => s.seatNumber.startsWith('C'))
                        .toList(),
                    'D': seats
                        .where((s) => s.seatNumber.startsWith('D'))
                        .toList(),
                    'E': seats
                        .where((s) => s.seatNumber.startsWith('E'))
                        .toList(),
                  };

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: DColors.softShadow,
                    ),
                    child: Column(
                      children: [
                        // Bus front indicator
                        Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            color: DColors.primary3,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.driver,
                                size: 14, color: DColors.neutral4),
                            const SizedBox(width: 4),
                            const Text('Front',
                                style: TextStyle(
                                    color: DColors.neutral4,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final col in ['A', 'B', 'C', 'D', 'E'])
                                  if (columns[col]!.isNotEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 3),
                                      child: Column(
                                        children: columns[col]!.map((seat) {
                                          return SeatWidget(
                                            seat: seat,
                                            isSelected:
                                                selectedSeatId == seat.seatId,
                                            onTap: seat.booked
                                                ? null
                                                : () => setState(() =>
                                                    selectedSeatId = seat.seatId),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }(),
              ),
            ),

            // ── Bottom CTA ──
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: selectedSeatId != null
                        ? DColors.primaryGradient
                        : null,
                    color: selectedSeatId == null ? DColors.neutral2 : null,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: selectedSeatId != null
                        ? [
                            BoxShadow(
                              color: DColors.primary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: ElevatedButton(
                    onPressed: selectedSeatId == null
                        ? null
                        : () {
                            // Resolve the picked seat's display number so we
                            // can show it on the payment summary without
                            // re-fetching seats inside PaymentScreen.
                            final seat = seatsState.data?.seats.firstWhere(
                              (e) => e.seatId == selectedSeatId,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                  schedule: widget.schedule,
                                  seatId: selectedSeatId!,
                                  seatNumber: seat?.seatNumber ?? '',
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      selectedSeatId == null
                          ? l.selectASeat
                          : '${l.bookSeat} — $priceText',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: selectedSeatId == null
                              ? DColors.neutral4
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Iconsax.personalcard,
              size: 10,
              color: color == DColors.neutral2 ? DColors.neutral4 : Colors.white),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: DColors.neutral5, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
