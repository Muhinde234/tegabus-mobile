import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart' as buy;
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';

class TicketScheduleService {
  TicketScheduleService({required ApiClient apiClient});

  // ── Mock schedule list ──────────────────────────────────────────────────────

  static final List<Schedule> _schedules = [
    Schedule(
      id: 1,
      bus: 'Volcano Express',
      origin: 'Kigali',
      destination: 'Musanze',
      price: '3500',
      departureTime: DateTime(2026, 4, 23, 6, 0),
      arrivalTime: DateTime(2026, 4, 23, 8, 30),
      totalSeats: 30,
      availableSeats: 20,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 2,
      bus: 'Jaguar Express',
      origin: 'Kigali',
      destination: 'Huye',
      price: '3000',
      departureTime: DateTime(2026, 4, 23, 7, 0),
      arrivalTime: DateTime(2026, 4, 23, 9, 30),
      totalSeats: 30,
      availableSeats: 15,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 3,
      bus: 'Virunga Express',
      origin: 'Kigali',
      destination: 'Rubavu',
      price: '4000',
      departureTime: DateTime(2026, 4, 23, 5, 30),
      arrivalTime: DateTime(2026, 4, 23, 8, 30),
      totalSeats: 30,
      availableSeats: 25,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 4,
      bus: 'Horizon Express',
      origin: 'Kigali',
      destination: 'Rwamagana',
      price: '1500',
      departureTime: DateTime(2026, 4, 23, 8, 0),
      arrivalTime: DateTime(2026, 4, 23, 9, 0),
      totalSeats: 30,
      availableSeats: 8,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 5,
      bus: 'Select Express',
      origin: 'Kigali',
      destination: 'Rusizi',
      price: '5500',
      departureTime: DateTime(2026, 4, 23, 6, 30),
      arrivalTime: DateTime(2026, 4, 23, 11, 30),
      totalSeats: 30,
      availableSeats: 12,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 6,
      bus: 'Jaguar Express',
      origin: 'Kigali',
      destination: 'Musanze',
      price: '3500',
      departureTime: DateTime(2026, 4, 23, 10, 0),
      arrivalTime: DateTime(2026, 4, 23, 12, 30),
      totalSeats: 30,
      availableSeats: 22,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 7,
      bus: 'Volcano Express',
      origin: 'Kigali',
      destination: 'Musanze',
      price: '3500',
      departureTime: DateTime(2026, 4, 24, 6, 0),
      arrivalTime: DateTime(2026, 4, 24, 8, 30),
      totalSeats: 30,
      availableSeats: 27,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 8,
      bus: 'Horizon Express',
      origin: 'Kigali',
      destination: 'Huye',
      price: '3000',
      departureTime: DateTime(2026, 4, 24, 7, 30),
      arrivalTime: DateTime(2026, 4, 24, 10, 0),
      totalSeats: 30,
      availableSeats: 18,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 9,
      bus: 'Virunga Express',
      origin: 'Musanze',
      destination: 'Rubavu',
      price: '1500',
      departureTime: DateTime(2026, 4, 24, 10, 0),
      arrivalTime: DateTime(2026, 4, 24, 11, 30),
      totalSeats: 30,
      availableSeats: 23,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    Schedule(
      id: 10,
      bus: 'Jaguar Express',
      origin: 'Kigali',
      destination: 'Rubavu',
      price: '4000',
      departureTime: DateTime(2026, 4, 24, 14, 0),
      arrivalTime: DateTime(2026, 4, 24, 17, 0),
      totalSeats: 30,
      availableSeats: 10,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
  ];

  // ── Mock booked tickets ─────────────────────────────────────────────────────

  static final List<Ticket> _myTickets = [
    Ticket(
      id: 101,
      origin: 'Kigali',
      destination: 'Musanze',
      price: '3500',
      seatNumber: 'A3',
      distance: 107,
      travelTime: '2h 30min',
      departureTime: DateTime(2026, 4, 22, 6, 0),
      arrivalTime: DateTime(2026, 4, 22, 8, 30),
      qrCodeUrl: '',
    ),
    Ticket(
      id: 102,
      origin: 'Kigali',
      destination: 'Huye',
      price: '3000',
      seatNumber: 'B2',
      distance: 135,
      travelTime: '2h 30min',
      departureTime: DateTime(2026, 4, 20, 7, 0),
      arrivalTime: DateTime(2026, 4, 20, 9, 30),
      qrCodeUrl: '',
    ),
  ];

  // ── Seat generator ──────────────────────────────────────────────────────────

  static List<SeatAvailability> _generateSeats(int scheduleId, int booked) {
    final seats = <SeatAvailability>[];
    const rows = ['A', 'B', 'C', 'D', 'E', 'F'];
    int seatId = (scheduleId - 1) * 30 + 1;
    int bookedCount = 0;
    for (final row in rows) {
      for (int n = 1; n <= 5; n++) {
        seats.add(SeatAvailability(
          seatId: seatId,
          seatNumber: '$row$n',
          isBooked: bookedCount < booked,
        ));
        if (bookedCount < booked) bookedCount++;
        seatId++;
      }
    }
    return seats;
  }

  // ── Service methods ─────────────────────────────────────────────────────────

  Future<SchedulesResponse> getAllSchedules({
    String? origin,
    String? destination,
    DateTime? date,
    int perPage = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final filtered = _schedules.where((s) {
      if (origin != null && s.origin != origin) return false;
      if (destination != null && s.destination != destination) return false;
      if (date != null) {
        final d = s.departureTime;
        if (d.year != date.year || d.month != date.month || d.day != date.day) {
          return false;
        }
      }
      return true;
    }).toList();

    return SchedulesResponse(
      data: filtered,
      links: const {'first': null, 'last': null, 'prev': null, 'next': null},
      meta: Meta(
        currentPage: 1,
        from: 1,
        lastPage: 1,
        links: const [],
        path: '/schedules',
        perPage: perPage,
        to: filtered.length,
        total: filtered.length,
      ),
    );
  }

  Future<MyTicketResponse> myTickets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MyTicketResponse(data: _myTickets);
  }

  Future<SingleScheduleResponse> getSchedule(int id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final s = _schedules.firstWhere(
      (s) => s.id == id,
      orElse: () => _schedules.first,
    );
    final booked = s.totalSeats - s.availableSeats;
    return SingleScheduleResponse(
      id: s.id,
      bus: s.bus,
      origin: s.origin,
      destination: s.destination,
      departureTime: s.departureTime,
      arrivalTime: s.arrivalTime,
      totalSeats: s.totalSeats,
      price: s.price,
      availableSeats: s.availableSeats,
      availabilities: _generateSeats(s.id, booked),
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
    );
  }

  Future<buy.BuyTicketResponse> buyTicket(int scheduleId, int seatId) async {
    await Future.delayed(const Duration(milliseconds: 900));
    final s = _schedules.firstWhere(
      (s) => s.id == scheduleId,
      orElse: () => _schedules.first,
    );
    final seatNumber = _generateSeats(s.id, 0)
        .firstWhere((seat) => seat.seatId == seatId,
            orElse: () => const SeatAvailability(
                  seatId: 1,
                  seatNumber: 'A1',
                  isBooked: false,
                ))
        .seatNumber;

    return buy.BuyTicketResponse(
      id: 200 + seatId,
      userId: 1,
      scheduleId: scheduleId,
      seatId: seatId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      qrCodeUrl: '',
      qrCodePublicId: 'tegabus-qr-$scheduleId-$seatId',
      schedule: buy.Schedule(
        id: s.id,
        busId: s.id,
        routeId: s.id,
        departureTime: s.departureTime,
        arrivalTime: s.arrivalTime,
        createdAt: s.createdAt,
        updatedAt: s.updatedAt,
        route: buy.Route(
          id: s.id,
          origin: s.origin,
          destination: s.destination,
          price: s.price,
          distanceKm: 100,
          travelTime: '2h 30min',
          routeCode: '${s.origin.substring(0, 3).toUpperCase()}-${s.destination.substring(0, 3).toUpperCase()}',
          createdAt: s.createdAt,
          updatedAt: s.updatedAt,
        ),
      ),
      seat: buy.Seat(
        id: seatId,
        seatNumber: seatNumber,
        busId: s.id,
        createdAt: s.createdAt,
        updatedAt: s.updatedAt,
      ),
    );
  }

  Future<MyTicketResponse> verifyTicket(String encryptedTicket) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MyTicketResponse(data: _myTickets);
  }

  Future<List<String>> getOrigins() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      'Kigali',
      'Musanze',
      'Huye',
      'Rubavu',
      'Rusizi',
      'Rwamagana',
      'Nyagatare',
      'Kibungo',
    ];
  }

  Future<List<String>> getDestinations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      'Kigali',
      'Musanze',
      'Huye',
      'Rubavu',
      'Rusizi',
      'Rwamagana',
      'Nyagatare',
      'Kibungo',
    ];
  }
}
