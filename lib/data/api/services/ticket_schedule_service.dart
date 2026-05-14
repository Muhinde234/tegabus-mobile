import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/api/services/auth_service.dart' show ApiException;
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';

/// Service that talks to the schedule/ticket endpoints. All responses are
/// normalised here so the rest of the app stays insulated from the backend
/// DTO shape.
class TicketScheduleService {
  final ApiClient _apiClient;

  TicketScheduleService({required ApiClient apiClient})
      : _apiClient = apiClient;

  // ── Companies ────────────────────────────────────────────────────────────

  Future<List<Company>> getCompanies() async {
    final res = await _apiClient.get('/api/v1/companies');
    final list = (res.data as List)
        .map((e) => Company.fromBackend(Map<String, dynamic>.from(e as Map)))
        .toList();
    // Keep the in-memory lookup up to date so cards anywhere can resolve a
    // company by id without an extra round trip.
    CompanyCache.replaceAll(list);
    return list;
  }

  /// Returns the cached company for [companyId]. Falls back to a generic
  /// branded shell if the cache hasn't been populated yet (e.g. deep link
  /// scenarios). Kept as a static so screens that already call
  /// `TicketScheduleService.companyFor(...)` don't have to be rewritten.
  static Company companyFor(dynamic identifier) {
    if (identifier == null) return CompanyCache.fallback();
    final id = identifier.toString();
    return CompanyCache.byId(id) ?? CompanyCache.fallback();
  }

  // ── Schedules ────────────────────────────────────────────────────────────

  Future<List<Schedule>> getAllSchedules({
    String? from,
    String? to,
    String? departureDate,
    String? companyId,
  }) async {
    final params = <String, dynamic>{};
    if (from != null && from.isNotEmpty) params['from'] = from;
    if (to != null && to.isNotEmpty) params['to'] = to;
    if (departureDate != null && departureDate.isNotEmpty) {
      params['departureDate'] = departureDate;
    }
    if (companyId != null && companyId.isNotEmpty) {
      params['companyId'] = companyId;
    }

    final res = await _apiClient.get('/api/v1/schedules', params: params);

    // The endpoint either returns a flat list or a Spring Page envelope. Be
    // permissive about both so we don't break if pagination is enabled later.
    final raw = res.data;
    final List items = raw is List
        ? raw
        : (raw is Map && raw['content'] is List ? raw['content'] as List : const []);

    return items
        .map((e) => _scheduleFromBackend(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<ScheduleSeats> getScheduleSeats(int scheduleId) async {
    final res = await _apiClient.get('/api/v1/schedules/$scheduleId/seats');
    final raw = Map<String, dynamic>.from(res.data as Map);

    final seatsJson = (raw['seats'] as List? ?? const [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    final seats = seatsJson.map((s) {
      return SeatAvailability(
        seatId: (s['seatId'] as num).toInt(),
        seatNumber: s['seatNumber']?.toString() ?? '',
        booked: s['booked'] == true,
        locked: s['locked'] == true,
        version: (s['version'] is num) ? (s['version'] as num).toInt() : 0,
      );
    }).toList();

    return ScheduleSeats(seats: seats);
  }

  // ── Booking ──────────────────────────────────────────────────────────────

  Future<BuyTicketResponse> buyTicket(int scheduleId, int seatId,
      {String? seatNumber}) async {
    // POST /api/v1/tickets — body identifies the seat-availability row to
    // lock. The schedule is implied by the seat availability on the backend.
    // Seat locking gives idempotency naturally even without the
    // `Idempotency-Key` header, so we don't need to thread it through here.
    final res = await _apiClient.post(
      '/api/v1/tickets',
      data: {
        'seatAvailabilityId': seatId,
        if (seatNumber != null && seatNumber.isNotEmpty) 'seatNumber': seatNumber,
      },
    );

    final data = Map<String, dynamic>.from(res.data as Map);
    return _ticketResponseFromBackend(data);
  }

  Future<List<Ticket>> getMyTickets() async {
    final res = await _apiClient.get('/api/v1/tickets/my');
    final raw = res.data;
    // Spring's `Page<T>` envelopes data inside `.content`.
    final List items = raw is List
        ? raw
        : (raw is Map && raw['content'] is List
            ? raw['content'] as List
            : const []);

    return items
        .map((e) => _ticketFromBackend(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  // ── Origins / Destinations ───────────────────────────────────────────────
  //
  // The backend doesn't expose dedicated origin/destination catalogue
  // endpoints, so we derive both from the currently-known schedules. The home
  // screen falls back to a static city list if the schedules haven't been
  // loaded yet — this matches the behaviour the UI already expects.

  static const _staticCities = <String>[
    'Kigali',
    'Musanze',
    'Huye',
    'Rubavu',
    'Nyagatare',
    'Rusizi',
    'Kampala',
    'Bujumbura',
  ];

  Future<List<String>> getOrigins() async {
    final schedules = await getAllSchedules();
    final origins = schedules.map((s) => s.from).toSet().toList()..sort();
    if (origins.isEmpty) return List<String>.from(_staticCities);
    return origins;
  }

  Future<List<String>> getDestinations() async {
    final schedules = await getAllSchedules();
    final dests = schedules.map((s) => s.to).toSet().toList()..sort();
    if (dests.isEmpty) return List<String>.from(_staticCities);
    return dests;
  }

  Future<List<String>> getDestinationsFor(String start) async {
    final schedules = await getAllSchedules(from: start);
    final dests = schedules.map((s) => s.to).toSet().toList()..sort();
    if (dests.isEmpty) {
      return _staticCities.where((c) => c.toLowerCase() != start.toLowerCase()).toList();
    }
    return dests;
  }

  // ── Chatbot ──────────────────────────────────────────────────────────────

  Future<String> sendChatMessage(String message) async {
    try {
      final res = await _apiClient.post(
        '/api/v1/ai/chat',
        data: {'message': message},
      );
      final data = res.data;
      if (data is Map) {
        return (data['reply'] ?? data['message'] ?? data['response'] ?? '')
            .toString();
      }
      return data?.toString() ?? '';
    } catch (_) {
      throw const ApiException(
          'Sorry, the assistant is unavailable right now. Please try again.');
    }
  }

  // ── Internal: backend → mobile DTO mapping ───────────────────────────────

  Schedule _scheduleFromBackend(Map<String, dynamic> json) {
    final price = (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0;
    final total = (json['totalSeats'] is num)
        ? (json['totalSeats'] as num).toInt()
        : 0;
    final remaining = (json['remainingSeats'] is num)
        ? (json['remainingSeats'] as num).toInt()
        : 0;
    return Schedule(
      id: (json['id'] as num).toInt(),
      bus: json['bus']?.toString() ?? '',
      price: price,
      companyId: json['companyId']?.toString(),
      companyName: json['companyName']?.toString(),
      driverName: json['driverName']?.toString(),
      driverPhone: json['driverPhone']?.toString(),
      from: json['from']?.toString() ?? '',
      to: json['to']?.toString() ?? '',
      departureTime: _parseDate(json['departureTime']),
      arrivalTime: _parseDate(json['arrivalTime']),
      totalSeats: total,
      remainingSeats: remaining,
    );
  }

  BuyTicketResponse _ticketResponseFromBackend(Map<String, dynamic> json) {
    final firstName = json['firstName']?.toString() ?? '';
    final lastName = json['lastName']?.toString() ?? '';
    final fullName = '${firstName} ${lastName}'.trim();
    final price = (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0;

    return BuyTicketResponse(
      id: json['id']?.toString() ?? '',
      fullName: fullName.isEmpty ? 'Passenger' : fullName,
      origin: json['from']?.toString() ?? '',
      destination: json['to']?.toString() ?? '',
      departureTime: _parseDate(json['departureTime']),
      // Backend `TicketResponse` doesn't carry arrival time — fall back to
      // departure + 3h so the confirmation screen still renders sensibly.
      arrivalTime: _parseDate(json['departureTime'])
          .add(const Duration(hours: 3)),
      bookingDate: DateTime.now().toIso8601String(),
      seatNumber: json['seatNumber']?.toString() ?? '',
      qrCodeUrl: json['qrCodeUrl']?.toString() ?? '',
      companyId: json['companyId']?.toString(),
      companyName: json['companyName']?.toString(),
      price: price,
      status: json['status']?.toString(),
    );
  }

  Ticket _ticketFromBackend(Map<String, dynamic> json) {
    final firstName = json['firstName']?.toString() ?? '';
    final lastName = json['lastName']?.toString() ?? '';
    final fullName = '$firstName $lastName'.trim();
    final price = (json['price'] is num) ? (json['price'] as num).toDouble() : null;
    final dep = _parseDate(json['departureTime']);

    return Ticket(
      id: json['id']?.toString() ?? '',
      origin: json['from']?.toString() ?? '',
      destination: json['to']?.toString() ?? '',
      seatNumber: json['seatNumber']?.toString() ?? '',
      departureTime: dep,
      arrivalTime: dep.add(const Duration(hours: 3)),
      bookingDate: DateTime.now().toIso8601String(),
      qrCodeUrl: json['qrCodeUrl']?.toString() ?? '',
      fullName: fullName.isEmpty ? null : fullName,
      price: price,
      companyId: json['companyId']?.toString(),
      companyName: json['companyName']?.toString(),
      status: json['status']?.toString(),
    );
  }

  DateTime _parseDate(dynamic raw) {
    if (raw == null) return DateTime.now();
    try {
      return DateTime.parse(raw.toString());
    } catch (_) {
      return DateTime.now();
    }
  }
}
