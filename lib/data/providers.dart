import 'dart:convert';

import 'package:flutter/material.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/api/services/auth_service.dart';
import 'package:mobile/data/api/services/ticket_schedule_service.dart';
import 'package:mobile/data/requests/login_request.dart';
import 'package:mobile/data/requests/sign_up_request.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/data/responses/company.dart';
import 'package:mobile/data/responses/login_response.dart';
import 'package:mobile/data/responses/my_ticket_response.dart';
import 'package:mobile/data/responses/profile.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/data/responses/signup_response.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';
import 'package:mobile/data/state/state.dart';

// ── Locale provider ──────────────────────────────────────────────────────────

class LocaleNotifier extends StateNotifier<Locale> {
  static const _storage = FlutterSecureStorage();

  LocaleNotifier(String code) : super(Locale(code));

  Future<void> setLocale(String code) async {
    await _storage.write(key: 'locale', value: code);
    state = Locale(code);
  }
}

final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) => LocaleNotifier('en'));

// ── Service providers ────────────────────────────────────────────────────────

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(apiClient: ref.watch(apiClientProvider));
});

final ticketScheduleServiceProvider =
    Provider<TicketScheduleService>((ref) {
  return TicketScheduleService(apiClient: ref.watch(apiClientProvider));
});

// ── Auth notifiers ───────────────────────────────────────────────────────────

class SignUpNotifier extends StateNotifier<State<SignupResponse>> {
  final AuthService _authService;
  SignUpNotifier(this._authService) : super(const State.init());

  Future<void> signUp(SignUpRequest request) async {
    state = const State.loading();
    try {
      state = State.success(await _authService.signUp(request));
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, State<SignupResponse>>((ref) {
  return SignUpNotifier(ref.watch(authServiceProvider));
});

class LoginNotifier extends StateNotifier<State<LoginResponse>> {
  final AuthService _authService;
  LoginNotifier(this._authService) : super(const State.init());

  Future<void> login(LoginRequest request) async {
    state = const State.loading();
    try {
      state = State.success(await _authService.login(request));
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, State<LoginResponse>>((ref) {
  return LoginNotifier(ref.watch(authServiceProvider));
});

class ProfileNotifier extends StateNotifier<State<Profile>> {
  final AuthService _authService;
  ProfileNotifier(this._authService) : super(const State.init()) {
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    state = const State.loading();
    try {
      state = State.success(await _authService.me());
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, State<Profile>>((ref) {
  return ProfileNotifier(ref.watch(authServiceProvider));
});

class LogoutNotifier extends StateNotifier<State<Object?>> {
  final AuthService _authService;
  LogoutNotifier(this._authService) : super(const State.init());

  Future<void> logout() async {
    state = const State.loading();
    try {
      await _authService.logout();
      state = const State.success(null);
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final logoutNotifierProvider =
    StateNotifierProvider<LogoutNotifier, State<Object?>>((ref) {
  return LogoutNotifier(ref.watch(authServiceProvider));
});

class ForgotPasswordNotifier extends StateNotifier<State<Object?>> {
  final AuthService _authService;
  ForgotPasswordNotifier(this._authService) : super(const State.init());

  Future<void> forgotPassword(String email) async {
    state = const State.loading();
    try {
      await _authService.forgotPassword(email);
      state = const State.success(null);
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final forgotPasswordNotifierProvider =
    StateNotifierProvider<ForgotPasswordNotifier, State<Object?>>((ref) {
  return ForgotPasswordNotifier(ref.watch(authServiceProvider));
});

// ── Schedule / seat notifiers ────────────────────────────────────────────────

class SchedulesNotifier extends StateNotifier<State<List<Schedule>>> {
  final TicketScheduleService _service;
  SchedulesNotifier(this._service) : super(const State.init());

  Future<void> fetchSchedules({
    String? from,
    String? to,
    DateTime? date,
    String? companyId,
  }) async {
    state = const State.loading();
    try {
      final departureDate = date != null
          ? '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}'
          : null;
      final schedules = await _service.getAllSchedules(
        from: from,
        to: to,
        departureDate: departureDate,
        companyId: companyId,
      );
      state = State.success(schedules);
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final schedulesNotifierProvider = StateNotifierProvider.autoDispose<
    SchedulesNotifier, State<List<Schedule>>>((ref) {
  return SchedulesNotifier(ref.watch(ticketScheduleServiceProvider));
});

// ── Companies ────────────────────────────────────────────────────────────────

class CompaniesNotifier extends StateNotifier<State<List<Company>>> {
  final TicketScheduleService _service;
  CompaniesNotifier(this._service) : super(const State.init()) {
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    state = const State.loading();
    try {
      state = State.success(await _service.getCompanies());
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final companiesNotifierProvider =
    StateNotifierProvider<CompaniesNotifier, State<List<Company>>>((ref) {
  return CompaniesNotifier(ref.watch(ticketScheduleServiceProvider));
});

class SeatsNotifier extends StateNotifier<State<ScheduleSeats>> {
  final TicketScheduleService _service;
  final int _scheduleId;

  SeatsNotifier(this._service, this._scheduleId) : super(const State.init()) {
    fetchSeats();
  }

  Future<void> fetchSeats() async {
    state = const State.loading();
    try {
      state = State.success(await _service.getScheduleSeats(_scheduleId));
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final seatsNotifierProvider = StateNotifierProvider.autoDispose
    .family<SeatsNotifier, State<ScheduleSeats>, int>((ref, id) {
  return SeatsNotifier(ref.watch(ticketScheduleServiceProvider), id);
});

// ── My tickets (stored locally after booking) ────────────────────────────────

class MyTicketsNotifier extends StateNotifier<State<MyTicketResponse>> {
  MyTicketsNotifier() : super(const State.init());

  static const _storageKey = 'my_tickets';
  static const _companyMapKey = 'my_tickets_company_map';
  final _storage = const FlutterSecureStorage();

  // Side-map of ticket id → company id. Lives next to the freezed Ticket model
  // so we don't have to regenerate freezed just to add a field. Resolved at
  // display time via `companyIdForTicket`. Includes the dummy seed mappings.
  static final Map<String, String> _ticketCompany = {
    'TGB-DEMO-001': 'volcano',
    'TGB-DEMO-002': 'ritco',
    'TGB-DEMO-003': 'horizon',
  };

  /// Public accessor for screens that want to badge a ticket with its company.
  /// Falls back to Volcano if the mapping is missing (e.g. legacy stored
  /// tickets booked before this map existed).
  static String companyIdForTicket(String ticketId) =>
      _ticketCompany[ticketId] ?? 'volcano';

  // Dummy seed tickets shown when nothing has been booked locally yet.
  // Remove this when integrating the real /me/tickets endpoint.
  static List<Ticket> _seedTickets() {
    final now = DateTime.now();
    DateTime at(int dayOffset, int hour, int minute) =>
        DateTime(now.year, now.month, now.day, hour, minute)
            .add(Duration(days: dayOffset));

    return [
      Ticket(
        id: 'TGB-DEMO-001',
        origin: 'Kigali',
        destination: 'Musanze',
        seatNumber: 'B4',
        departureTime: at(2, 7, 30),
        arrivalTime: at(2, 10, 0),
        bookingDate: now.toIso8601String(),
        qrCodeUrl: '',
        fullName: 'Denis Rukwaya',
        price: 5000,
      ),
      Ticket(
        id: 'TGB-DEMO-002',
        origin: 'Kigali',
        destination: 'Rubavu',
        seatNumber: 'C7',
        departureTime: at(5, 6, 0),
        arrivalTime: at(5, 9, 30),
        bookingDate: now.toIso8601String(),
        qrCodeUrl: '',
        fullName: 'Denis Rukwaya',
        price: 7000,
      ),
      Ticket(
        id: 'TGB-DEMO-003',
        origin: 'Kigali',
        destination: 'Huye',
        seatNumber: 'A2',
        departureTime: at(-7, 9, 0),
        arrivalTime: at(-7, 11, 30),
        bookingDate: now.toIso8601String(),
        qrCodeUrl: '',
        fullName: 'Denis Rukwaya',
        price: 4500,
      ),
    ];
  }

  Future<void> _loadCompanyMap() async {
    final raw = await _storage.read(key: _companyMapKey);
    if (raw == null) return;
    try {
      final decoded = (jsonDecode(raw) as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v.toString()));
      _ticketCompany.addAll(decoded);
    } catch (_) {
      // Ignore corrupted side-map; the seed entries still apply.
    }
  }

  Future<void> _persistCompanyMap() async {
    await _storage.write(
      key: _companyMapKey,
      value: jsonEncode(_ticketCompany),
    );
  }

  Future<void> fetchMyTickets() async {
    state = const State.loading();
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await _loadCompanyMap();
      final raw = await _storage.read(key: _storageKey);
      final stored = raw == null
          ? <Ticket>[]
          : (jsonDecode(raw) as List)
              .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
              .toList();

      // Combine any locally-booked tickets with the dummy seed tickets.
      final combined = [...stored, ..._seedTickets()];
      state = State.success(MyTicketResponse(data: combined));
    } catch (e) {
      state = State.success(MyTicketResponse(data: _seedTickets()));
    }
  }

  Future<void> addTicket(
    BuyTicketResponse booking, {
    double? price,
    String? companyId,
  }) async {
    final ticket = Ticket(
      id: booking.id,
      origin: booking.origin,
      destination: booking.destination,
      seatNumber: booking.seatNumber,
      departureTime: booking.departureTime,
      arrivalTime: booking.arrivalTime,
      bookingDate: booking.bookingDate,
      qrCodeUrl: booking.qrCodeUrl,
      fullName: booking.fullName,
      price: price,
    );

    if (companyId != null) {
      _ticketCompany[booking.id] = companyId;
      await _persistCompanyMap();
    }

    // Read existing storage so a fresh booking shows up in My Tickets even
    // when the user hasn't opened that tab yet (state.data may still be null).
    final raw = await _storage.read(key: _storageKey);
    final stored = raw == null
        ? <Ticket>[]
        : (jsonDecode(raw) as List)
            .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
            .toList();

    final persisted = [ticket, ...stored];
    await _storage.write(
      key: _storageKey,
      value: jsonEncode(persisted.map((t) => t.toJson()).toList()),
    );

    // For the live UI, surface persisted bookings + dummy seeds.
    state = State.success(
      MyTicketResponse(data: [...persisted, ..._seedTickets()]),
    );
  }
}

final myTicketsNotifierProvider =
    StateNotifierProvider<MyTicketsNotifier, State<MyTicketResponse>>((ref) {
  return MyTicketsNotifier();
});

// ── Buy ticket notifier ──────────────────────────────────────────────────────

class BuyTicketNotifier extends StateNotifier<State<BuyTicketResponse>> {
  final TicketScheduleService _service;
  final MyTicketsNotifier _myTickets;

  BuyTicketNotifier(this._service, this._myTickets)
      : super(const State.init());

  Future<void> buyTicket(int scheduleId, int seatId, {double? price}) async {
    state = const State.loading();
    try {
      final ticket = await _service.buyTicket(scheduleId, seatId);
      final company = TicketScheduleService.companyFor(scheduleId);
      await _myTickets.addTicket(
        ticket,
        price: price,
        companyId: company.id,
      );
      state = State.success(ticket);
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final buyTicketNotifierProvider = StateNotifierProvider.autoDispose<
    BuyTicketNotifier, State<BuyTicketResponse>>((ref) {
  return BuyTicketNotifier(
    ref.watch(ticketScheduleServiceProvider),
    ref.read(myTicketsNotifierProvider.notifier),
  );
});

// ── Location providers ───────────────────────────────────────────────────────

class OriginsNotifier extends StateNotifier<State<List<String>>> {
  final TicketScheduleService _service;
  OriginsNotifier(this._service) : super(const State.init()) {
    fetchOrigins();
  }

  Future<void> fetchOrigins() async {
    state = const State.loading();
    try {
      state = State.success(await _service.getOrigins());
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final originsNotifierProvider =
    StateNotifierProvider<OriginsNotifier, State<List<String>>>((ref) {
  return OriginsNotifier(ref.watch(ticketScheduleServiceProvider));
});

class DestinationsNotifier extends StateNotifier<State<List<String>>> {
  final TicketScheduleService _service;
  DestinationsNotifier(this._service) : super(const State.init()) {
    fetchDestinations();
  }

  Future<void> fetchDestinations({String? forStart}) async {
    state = const State.loading();
    try {
      final list = forStart != null
          ? await _service.getDestinationsFor(forStart)
          : await _service.getDestinations();
      state = State.success(list);
    } catch (e) {
      state = State.error(Exception(e.toString()));
    }
  }
}

final destinationsNotifierProvider =
    StateNotifierProvider<DestinationsNotifier, State<List<String>>>((ref) {
  return DestinationsNotifier(ref.watch(ticketScheduleServiceProvider));
});

// ── Chatbot notifier ─────────────────────────────────────────────────────────

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  ChatMessage(
      {required this.text, required this.isUser, required this.timestamp});
}

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final TicketScheduleService _service;
  bool isLoading = false;

  ChatNotifier(this._service) : super([
    ChatMessage(
      text:
          'Hello! I\'m the TegaBus assistant. How can I help you with your journey today?',
      isUser: false,
      timestamp: DateTime.now(),
    ),
  ]);

  Future<void> sendMessage(String message) async {
    state = [
      ...state,
      ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
    ];
    isLoading = true;
    try {
      final reply = await _service.sendChatMessage(message);
      state = [
        ...state,
        ChatMessage(text: reply, isUser: false, timestamp: DateTime.now()),
      ];
    } catch (e) {
      state = [
        ...state,
        ChatMessage(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ];
    } finally {
      isLoading = false;
    }
  }
}

final chatNotifierProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier(ref.watch(ticketScheduleServiceProvider));
});
