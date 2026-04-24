import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/providers.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/screens/booking_confirmation_screen.dart';
import 'package:mobile/utils/colors.dart';
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
    final seatsState =
        ref.watch(seatsNotifierProvider(widget.schedule.id));
    final buyState = ref.watch(buyTicketNotifierProvider);
    final s = widget.schedule;

    ref.listen(buyTicketNotifierProvider, (_, curr) {
      if (curr.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                BookingConfirmationScreen(booking: curr.data!),
          ),
        );
      } else if (curr.isError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(curr.error.toString()),
          backgroundColor: DColors.danger6,
        ));
      }
    });

    final dep = DateFormat('h:mm a').format(s.departureTime);
    final arr = DateFormat('h:mm a').format(s.arrivalTime);
    final dur = s.arrivalTime.difference(s.departureTime);
    final durationText = '${dur.inHours}h ${dur.inMinutes % 60}m';
    final priceText =
        NumberFormat('#,###').format(s.price.toInt()) + ' RWF';

    return Scaffold(
      appBar: AppBar(
        title: Text('${s.from} → ${s.to}'),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Schedule summary header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: DColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s.bus,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                      Text(priceText,
                          style: const TextStyle(
                              color: DColors.secondary,
                              fontWeight: FontWeight.w800,
                              fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.from,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            Text(dep,
                                style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(Icons.arrow_forward,
                              color: Colors.white54, size: 18),
                          Text(durationText,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 11)),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(s.to,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            Text(arr,
                                style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _legend(DColors.success5, 'Available'),
                  const SizedBox(width: 20),
                  _legend(DColors.warning5, 'Selected'),
                  const SizedBox(width: 20),
                  _legend(DColors.neutral3, 'Booked'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Seat grid
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref
                    .read(seatsNotifierProvider(widget.schedule.id).notifier)
                    .fetchSeats(),
                child: () {
                  if (seatsState.isLoading || seatsState.isInit) {
                    return const SeatLayoutShimmer();
                  }
                  if (seatsState.isError) {
                    return Center(
                        child: Text('Failed to load seats.\n'
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

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final col in ['A', 'B', 'C', 'D', 'E'])
                            if (columns[col]!.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
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
                  );
                }(),
              ),
            ),

            // Book button
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: DColors.neutral2)),
              ),
              child: SafeArea(
                top: false,
                child: ElevatedButton(
                  onPressed: selectedSeatId == null || buyState.isLoading
                      ? null
                      : () => ref
                          .read(buyTicketNotifierProvider.notifier)
                          .buyTicket(widget.schedule.id, selectedSeatId!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedSeatId == null
                        ? DColors.neutral2
                        : DColors.primary,
                    disabledBackgroundColor: DColors.neutral2,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: buyState.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          selectedSeatId == null
                              ? 'Select a Seat'
                              : 'Book Seat',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
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
        Icon(Icons.event_seat, color: color, size: 18),
        const SizedBox(width: 4),
        Text(label,
            style:
                const TextStyle(fontSize: 12, color: DColors.neutral5)),
      ],
    );
  }
}
