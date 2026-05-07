import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';

// NOTE: Service stubbed with dummy data for UI development.
// Replace each method body with the real API call when integrating.
class TicketScheduleService {
  // ignore: unused_field
  final ApiClient _apiClient;

  TicketScheduleService({required ApiClient apiClient})
      : _apiClient = apiClient;

  static const _fakeDelay = Duration(milliseconds: 600);

  // ── Dummy catalogue ──────────────────────────────────────────────────────
  static final _baseDate = DateTime.now();

  static DateTime _at(int dayOffset, int hour, int minute) =>
      DateTime(_baseDate.year, _baseDate.month, _baseDate.day, hour, minute)
          .add(Duration(days: dayOffset));

  static final List<Schedule> _dummySchedules = [
    Schedule(
      id: 1,
      bus: 'Volcano Express - VE-001',
      price: 5000,
      driverName: 'Jean Bosco',
      driverPhone: '+250 788 111 222',
      from: 'Kigali',
      to: 'Musanze',
      departureTime: _at(0, 7, 30),
      arrivalTime: _at(0, 10, 0),
      totalSeats: 48,
      remainingSeats: 32,
    ),
    Schedule(
      id: 2,
      bus: 'Horizon Coach - HC-104',
      price: 4500,
      driverName: 'Eric Manzi',
      driverPhone: '+250 788 222 333',
      from: 'Kigali',
      to: 'Huye',
      departureTime: _at(0, 9, 0),
      arrivalTime: _at(0, 11, 30),
      totalSeats: 48,
      remainingSeats: 18,
    ),
    Schedule(
      id: 3,
      bus: 'Ritco Star - RS-220',
      price: 7000,
      driverName: 'Patrick Niyonzima',
      driverPhone: '+250 788 333 444',
      from: 'Kigali',
      to: 'Rubavu',
      departureTime: _at(0, 6, 0),
      arrivalTime: _at(0, 9, 30),
      totalSeats: 48,
      remainingSeats: 24,
    ),
    Schedule(
      id: 4,
      bus: 'Virunga Travel - VT-077',
      price: 12000,
      driverName: 'Alphonse Mugisha',
      driverPhone: '+250 788 444 555',
      from: 'Kigali',
      to: 'Rusizi',
      departureTime: _at(1, 5, 30),
      arrivalTime: _at(1, 11, 0),
      totalSeats: 48,
      remainingSeats: 8,
    ),
    Schedule(
      id: 5,
      bus: 'Volcano Express - VE-005',
      price: 3500,
      driverName: 'Diane Uwase',
      driverPhone: '+250 788 555 666',
      from: 'Musanze',
      to: 'Rubavu',
      departureTime: _at(0, 14, 0),
      arrivalTime: _at(0, 15, 45),
      totalSeats: 48,
      remainingSeats: 40,
    ),
    Schedule(
      id: 6,
      bus: 'Horizon Coach - HC-118',
      price: 6500,
      driverName: 'Olivier Habimana',
      driverPhone: '+250 788 666 777',
      from: 'Kigali',
      to: 'Nyagatare',
      departureTime: _at(0, 12, 30),
      arrivalTime: _at(0, 15, 30),
      totalSeats: 48,
      remainingSeats: 21,
    ),
    Schedule(
      id: 7,
      bus: 'Trinity Liner - TL-009',
      price: 15000,
      driverName: 'Cedric Nshuti',
      driverPhone: '+250 788 777 888',
      from: 'Kigali',
      to: 'Kampala',
      departureTime: _at(1, 21, 0),
      arrivalTime: _at(2, 6, 30),
      totalSeats: 48,
      remainingSeats: 12,
    ),
    Schedule(
      id: 8,
      bus: 'Ritco Star - RS-301',
      price: 5500,
      driverName: 'Aimable Kayitare',
      driverPhone: '+250 788 888 999',
      from: 'Huye',
      to: 'Kigali',
      departureTime: _at(0, 16, 0),
      arrivalTime: _at(0, 18, 30),
      totalSeats: 48,
      remainingSeats: 30,
    ),
    Schedule(
      id: 9,
      bus: 'Virunga Travel - VT-085',
      price: 13500,
      driverName: 'Fidele Bizimana',
      driverPhone: '+250 788 999 000',
      from: 'Kigali',
      to: 'Rusizi',
      departureTime: _at(2, 6, 0),
      arrivalTime: _at(2, 11, 30),
      totalSeats: 48,
      remainingSeats: 22,
    ),
    Schedule(
      id: 10,
      bus: 'Trinity Liner - TL-012',
      price: 16000,
      driverName: 'Innocent Karangwa',
      driverPhone: '+250 788 100 200',
      from: 'Kigali',
      to: 'Bujumbura',
      departureTime: _at(2, 22, 0),
      arrivalTime: _at(3, 8, 0),
      totalSeats: 48,
      remainingSeats: 17,
    ),
  ];

  /// Mapping of schedule id → company id. Lives next to schedules so we don't
  /// have to regenerate freezed. When the API arrives, drop this and put
  /// `companyId` on the Schedule DTO.
  static const Map<int, String> _scheduleCompany = {
    1: 'volcano',
    2: 'horizon',
    3: 'ritco',
    4: 'virunga',
    5: 'volcano',
    6: 'horizon',
    7: 'trinity',
    8: 'ritco',
    9: 'virunga',
    10: 'trinity',
  };

  /// Public lookup so screens / cards can resolve a schedule's company.
  static Company companyFor(int scheduleId) {
    final id = _scheduleCompany[scheduleId] ?? 'volcano';
    return DummyCompanies.byId(id);
  }

  static const List<String> _origins = [
    'Kigali',
    'Musanze',
    'Huye',
    'Rubavu',
    'Nyagatare',
    'Rusizi',
  ];

  static const List<String> _destinations = [
    'Kigali',
    'Musanze',
    'Huye',
    'Rubavu',
    'Rusizi',
    'Nyagatare',
    'Kampala',
    'Bujumbura',
  ];

  // ── API methods ──────────────────────────────────────────────────────────

  Future<List<Company>> getCompanies() async {
    await Future.delayed(_fakeDelay);
    return List<Company>.from(DummyCompanies.all);
  }

  Future<List<Schedule>> getAllSchedules({
    String? from,
    String? to,
    String? departureDate,
    String? companyId,
  }) async {
    await Future.delayed(_fakeDelay);
    return _dummySchedules.where((s) {
      if (from != null && from.isNotEmpty &&
          s.from.toLowerCase() != from.toLowerCase()) {
        return false;
      }
      if (to != null && to.isNotEmpty &&
          s.to.toLowerCase() != to.toLowerCase()) {
        return false;
      }
      if (companyId != null && companyId.isNotEmpty) {
        if (_scheduleCompany[s.id] != companyId) return false;
      }
      return true;
    }).toList();
  }

  Future<ScheduleSeats> getScheduleSeats(int scheduleId) async {
    await Future.delayed(_fakeDelay);

    // Pre-book a deterministic set of seats per schedule so it looks realistic.
    final bookedSet = <String>{
      'A2', 'A5', 'B1', 'B7', 'C3', 'C4', 'D9', 'D12',
      if (scheduleId.isEven) ...['A8', 'B11', 'C7'],
      if (scheduleId.isOdd) ...['B4', 'D2', 'E1'],
    };

    int seatId = 1;
    final seats = <SeatAvailability>[];

    for (final col in ['A', 'B', 'C', 'D']) {
      for (var row = 1; row <= 12; row++) {
        final number = '$col$row';
        seats.add(SeatAvailability(
          seatId: seatId++,
          seatNumber: number,
          booked: bookedSet.contains(number),
        ));
      }
    }
    // Back-row "E" seats (5 across).
    for (var row = 1; row <= 5; row++) {
      final number = 'E$row';
      seats.add(SeatAvailability(
        seatId: seatId++,
        seatNumber: number,
        booked: bookedSet.contains(number),
      ));
    }

    return ScheduleSeats(seats: seats);
  }

  Future<BuyTicketResponse> buyTicket(int scheduleId, int seatId) async {
    await Future.delayed(_fakeDelay);

    final schedule = _dummySchedules.firstWhere(
      (s) => s.id == scheduleId,
      orElse: () => _dummySchedules.first,
    );

    // Reverse-engineer a plausible seat number from the seatId.
    final cols = ['A', 'B', 'C', 'D'];
    final String seatNumber;
    if (seatId <= 48) {
      final colIdx = (seatId - 1) ~/ 12;
      final row = ((seatId - 1) % 12) + 1;
      seatNumber = '${cols[colIdx]}$row';
    } else {
      seatNumber = 'E${seatId - 48}';
    }

    final bookingId = 'TGB-${DateTime.now().millisecondsSinceEpoch}';

    return BuyTicketResponse(
      id: bookingId,
      fullName: 'Denis Rukwaya',
      phoneNumber: '+250 788 123 456',
      origin: schedule.from,
      destination: schedule.to,
      departureTime: schedule.departureTime,
      arrivalTime: schedule.arrivalTime,
      bookingDate: DateTime.now().toIso8601String(),
      seatNumber: seatNumber,
      qrCodeUrl: '',
    );
  }

  Future<List<String>> getOrigins() async {
    await Future.delayed(_fakeDelay);
    return List<String>.from(_origins);
  }

  Future<List<String>> getDestinations() async {
    await Future.delayed(_fakeDelay);
    return List<String>.from(_destinations);
  }

  Future<List<String>> getDestinationsFor(String start) async {
    await Future.delayed(_fakeDelay);
    return _destinations.where((d) => d.toLowerCase() != start.toLowerCase()).toList();
  }

  Future<String> sendChatMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final lower = message.toLowerCase();
    if (lower.contains('route')) {
      return 'We currently serve Kigali, Musanze, Huye, Rubavu, Nyagatare, Rusizi, '
          'Kampala and Bujumbura. Tap "Explore" to see live schedules.';
    }
    if (lower.contains('compan')) {
      return 'TegaBus partners with Volcano Express, Horizon Coach, Ritco Star, '
          'Virunga Travel and Trinity Liner. Tap a company on the home screen '
          'to see its schedules.';
    }
    if (lower.contains('book') || lower.contains('how')) {
      return 'Booking is easy: pick your origin and destination on the home screen, '
          'choose a date, select a bus, pick your seat, and confirm. Your e-ticket '
          'with QR code will appear under "My Tickets".';
    }
    if (lower.contains('price') || lower.contains('cost') ||
        lower.contains('huye')) {
      return 'Kigali → Huye is currently 4,500 RWF on Horizon Coach. '
          'Prices vary by operator and time of day.';
    }
    if (lower.contains('refund') || lower.contains('cancel')) {
      return 'Tickets can be cancelled up to 2 hours before departure for a full refund. '
          'Contact support@tegabus.rw for help.';
    }
    return 'Thanks for your message! I\'m here to help with routes, bookings, '
        'pricing, or any TegaBus question. What would you like to know?';
  }
}
