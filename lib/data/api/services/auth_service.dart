import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/requests/login_request.dart';
import 'package:mobile/data/requests/sign_up_request.dart';
import 'package:mobile/data/responses/login_response.dart';
import 'package:mobile/data/responses/profile.dart';
import 'package:mobile/data/responses/signup_response.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<SignupResponse> signUp(SignUpRequest request) async {
    final body = {
      'firstName': request.firstName,
      'lastName': request.lastName,
      'email': request.email,
      'phoneNumber': request.phoneNumber,
      'nationality': request.nationality,
      'password': request.password,
      'confirmPassword': request.password,
    };

    final res = await _apiClient.post('/api/v1/auth/sign-up', data: body);
    final data = res.data as Map<String, dynamic>;

    // Backend signup endpoint returns { message: "..." } only. The user is
    // created server-side with role=PASSENGER and email already verified, so
    // we synthesise the minimal user summary the UI expects.
    return SignupResponse(
      message: data['message']?.toString() ?? 'Account created successfully',
      user: SignupUser(
        id: '',
        email: request.email,
        fullName: '${request.firstName} ${request.lastName}',
        role: 'PASSENGER',
      ),
    );
  }

  Future<LoginResponse> login(LoginRequest request) async {
    final res = await _apiClient.post(
      '/api/v1/auth/login',
      data: {
        'email': request.email,
        'password': request.password,
      },
    );

    final loginResponse = LoginResponse.fromJson(res.data as Map<String, dynamic>);

    // Enforce mobile = PASSENGER only. Reject any other role at the gate.
    if (loginResponse.user.role.toUpperCase() != 'PASSENGER') {
      throw Exception(
        'This app is for passengers only. Staff accounts must use the web dashboard.',
      );
    }

    await _apiClient.storage.write(key: 'token', value: loginResponse.accessToken);
    await _apiClient.storage.write(
      key: 'user_data',
      value: jsonEncode(loginResponse.user.toJson()),
    );
    return loginResponse;
  }

  Future<void> logout() async {
    await _apiClient.storage.delete(key: 'token');
    await _apiClient.storage.delete(key: 'user_data');
  }

  Future<void> forgotPassword(String email) async {
    await _apiClient.post(
      '/api/v1/auth/forgot-password-otp',
      data: {'email': email},
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _apiClient.put(
      '/api/v1/users/profile/password',
      data: {
        'oldPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }

  Future<Profile> me() async {
    final res = await _apiClient.get('/api/v1/users/me');
    final data = Map<String, dynamic>.from(res.data as Map);

    // Backend role is an enum (PASSENGER, ADMIN, …). Anything other than
    // PASSENGER means a stale or wrong session — boot it.
    final role = data['role']?.toString().toUpperCase() ?? '';
    if (role != 'PASSENGER') {
      await logout();
      throw Exception('Session is not a passenger account. Please sign in again.');
    }

    return Profile.fromJson(_profileJson(data));
  }

  Future<Profile> updateProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final res = await _apiClient.put('/api/v1/users/$userId', data: data);
    final raw = Map<String, dynamic>.from(res.data as Map);
    return Profile.fromJson(_profileJson(raw));
  }

  /// Reads the cached session (if any). Returns null when there is no token,
  /// or when the cached user is not a PASSENGER (defence in depth — a stale
  /// session from a different role gets cleared).
  Future<AuthUser?> cachedUser() async {
    final token = await _apiClient.storage.read(key: 'token');
    if (token == null || token.isEmpty) return null;

    final raw = await _apiClient.storage.read(key: 'user_data');
    if (raw == null) return null;

    try {
      final user = AuthUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      if (user.role.toUpperCase() != 'PASSENGER') {
        await logout();
        return null;
      }
      return user;
    } catch (_) {
      await logout();
      return null;
    }
  }

  /// Maps backend [UserResponseDto] into the mobile [Profile] DTO. Backend
  /// returns `createdAt`/`updatedAt` as ISO strings and may omit fields like
  /// `profilePicUrl` or `nationality` — we coerce safely so freezed parsing
  /// never throws.
  Map<String, dynamic> _profileJson(Map<String, dynamic> raw) {
    return {
      'id': raw['id']?.toString() ?? '',
      'firstName': raw['firstName']?.toString() ?? '',
      'lastName': raw['lastName']?.toString() ?? '',
      'email': raw['email']?.toString() ?? '',
      'profilePicUrl': raw['profilePicUrl'],
      'phoneNumber': raw['phoneNumber']?.toString() ?? '',
      'nationality': raw['nationality']?.toString() ?? '',
      'role': raw['role']?.toString() ?? 'PASSENGER',
      'createdAt': raw['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
      'updatedAt': raw['updatedAt']?.toString() ?? DateTime.now().toIso8601String(),
    };
  }
}

/// Convenience extractor that prefers the backend's plain-text error message
/// when available, falling back to whatever Dio surfaced.
String extractApiError(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          error.message ??
          'Request failed';
    }
    if (data is String && data.isNotEmpty) return data;
    return error.message ?? 'Network error';
  }
  // Strip the leading "Exception: " that Dart's default toString adds so the
  // raw human message bubbles up to the UI cleanly.
  final str = error.toString();
  return str.startsWith('Exception: ') ? str.substring(11) : str;
}

/// Lightweight exception whose [toString] returns the raw message — without
/// Dart's default `Exception: ` prefix. Lets screens that print
/// `state.error.toString()` show a clean backend message directly.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}
