import 'package:flutter/material.dart' show Locale, ThemeMode;
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

// ── Theme mode provider ──────────────────────────────────────────────────────
//
// Persists the user's choice (light/dark/system) to secure storage so the
// preference survives app restarts. The actual theming switch happens in
// main.dart by reading this provider and feeding `theme` / `darkTheme` /
// `themeMode` into the MaterialApp.

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _storage = FlutterSecureStorage();
  static const _key = 'theme_mode';

  ThemeModeNotifier(super.initial);

  Future<void> setMode(ThemeMode mode) async {
    await _storage.write(key: _key, value: _encode(mode));
    state = mode;
  }

  static ThemeMode decode(String? raw) {
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        // Default for first launch (no value stored yet): force light. The
        // user can opt into dark or system via Profile → Appearance.
        return ThemeMode.light;
    }
  }

  static String _encode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

/// Override this in `ProviderScope` at startup with the value loaded from
/// secure storage so the first frame already has the user's preference.
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(ThemeMode.light),
);

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
      state = State.error(ApiException(extractApiError(e)));
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
      state = State.error(ApiException(extractApiError(e)));
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
      state = State.error(ApiException(extractApiError(e)));
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
      state = State.error(ApiException(extractApiError(e)));
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
  final TicketScheduleService _service;
  MyTicketsNotifier(this._service) : super(const State.init());

  // Side-map of ticket id → company id. Kept as an in-memory cache only —
  // when the backend returns `companyId` on the ticket itself we use that
  // directly, but recently booked tickets fall back to this map until the
  // next /tickets/my fetch.
  static final Map<String, String> _ticketCompany = <String, String>{};

  /// Resolves a ticket's company id. Prefers an entry written by [addTicket],
  /// otherwise returns an empty string so the UI uses [CompanyCache.fallback].
  static String companyIdForTicket(String ticketId) =>
      _ticketCompany[ticketId] ?? '';

  Future<void> fetchMyTickets() async {
    state = const State.loading();
    try {
      final tickets = await _service.getMyTickets();
      for (final t in tickets) {
        if (t.companyId != null && t.companyId!.isNotEmpty) {
          _ticketCompany[t.id] = t.companyId!;
        }
      }
      state = State.success(MyTicketResponse(data: tickets));
    } catch (e) {
      state = State.error(ApiException(extractApiError(e)));
    }
  }

  /// Push a freshly booked ticket into the local state so the My Tickets tab
  /// shows it without waiting for a refetch.
  Future<void> addTicket(
    BuyTicketResponse booking, {
    double? price,
    String? companyId,
  }) async {
    final resolvedCompanyId = companyId ?? booking.companyId;
    if (resolvedCompanyId != null && resolvedCompanyId.isNotEmpty) {
      _ticketCompany[booking.id] = resolvedCompanyId;
    }

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
      price: price ?? booking.price,
      companyId: resolvedCompanyId,
      companyName: booking.companyName,
      status: booking.status,
    );

    final existing = state.data?.data ?? const <Ticket>[];
    state = State.success(MyTicketResponse(data: [ticket, ...existing]));
  }
}

final myTicketsNotifierProvider =
    StateNotifierProvider<MyTicketsNotifier, State<MyTicketResponse>>((ref) {
  return MyTicketsNotifier(ref.watch(ticketScheduleServiceProvider));
});

// ── Buy ticket notifier ──────────────────────────────────────────────────────

class BuyTicketNotifier extends StateNotifier<State<BuyTicketResponse>> {
  final TicketScheduleService _service;
  final MyTicketsNotifier _myTickets;

  BuyTicketNotifier(this._service, this._myTickets)
      : super(const State.init());

  Future<void> buyTicket(
    int scheduleId,
    int seatId, {
    double? price,
    String? seatNumber,
    String? companyId,
  }) async {
    state = const State.loading();
    try {
      final ticket = await _service.buyTicket(
        scheduleId,
        seatId,
        seatNumber: seatNumber,
      );
      // Prefer the company id the backend returned on the ticket; fall back
      // to whatever the caller supplied (from the originating schedule).
      await _myTickets.addTicket(
        ticket,
        price: price,
        companyId: ticket.companyId ?? companyId,
      );
      state = State.success(ticket);
    } catch (e) {
      state = State.error(ApiException(extractApiError(e)));
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
