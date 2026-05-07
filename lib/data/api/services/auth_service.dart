import 'dart:convert';

import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/requests/login_request.dart';
import 'package:mobile/data/requests/sign_up_request.dart';
import 'package:mobile/data/responses/login_response.dart';
import 'package:mobile/data/responses/profile.dart';
import 'package:mobile/data/responses/signup_response.dart';

// NOTE: Service stubbed with dummy data for UI development.
// Replace each method body with the real API call when integrating.
class AuthService {
  final ApiClient _apiClient;

  AuthService({required ApiClient apiClient}) : _apiClient = apiClient;

  static const _fakeDelay = Duration(milliseconds: 600);

  Future<SignupResponse> signUp(SignUpRequest request) async {
    await Future.delayed(_fakeDelay);
    return SignupResponse(
      message: 'Account created successfully',
      user: SignupUser(
        id: 'dummy-user-id',
        email: request.email,
        fullName: '${request.firstName} ${request.lastName}',
        role: 'PASSENGER',
      ),
    );
  }

  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(_fakeDelay);

    final user = AuthUser(
      id: 'dummy-user-id',
      email: request.email,
      fullName: 'Denis Rukwaya',
      role: 'PASSENGER',
    );

    final loginResponse = LoginResponse(
      message: 'Login successful',
      accessToken: 'dummy-access-token',
      expiresIn: 3600,
      user: user,
    );

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
    await Future.delayed(_fakeDelay);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(_fakeDelay);
  }

  Future<Profile> me() async {
    await Future.delayed(_fakeDelay);
    return Profile(
      id: 'dummy-user-id',
      firstName: 'Denis',
      lastName: 'Rukwaya',
      email: 'denis.rukwaya@tegabus.rw',
      profilePicUrl: null,
      phoneNumber: '+250 788 123 456',
      nationality: 'Rwandan',
      role: 'PASSENGER',
      createdAt: DateTime(2024, 8, 14),
      updatedAt: DateTime(2026, 4, 22),
    );
  }

  Future<Profile> updateProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(_fakeDelay);
    return me();
  }
}
