import 'dart:convert';

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
    try {
      final response = await _apiClient.post(
        '/api/v1/auth/sign-up',
        data: request.toJson(),
      );
      return SignupResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/auth/login',
        data: request.toJson(),
      );
      final loginResponse =
          LoginResponse.fromJson(response.data as Map<String, dynamic>);
      await _apiClient.storage.write(
          key: 'token', value: loginResponse.accessToken);
      await _apiClient.storage.write(
          key: 'user_data',
          value: jsonEncode(loginResponse.user.toJson()));
      return loginResponse;
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<void> logout() async {
    await _apiClient.storage.delete(key: 'token');
    await _apiClient.storage.delete(key: 'user_data');
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _apiClient.post(
        '/api/v1/auth/forgot-password',
        data: {'email': email},
      );
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiClient.post(
        '/api/v1/auth/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<Profile> me() async {
    try {
      final raw = await _apiClient.storage.read(key: 'user_data');
      if (raw == null) throw Exception('Not authenticated');
      final userData = jsonDecode(raw) as Map<String, dynamic>;
      final userId = userData['id'] as String;
      final response = await _apiClient.get('/api/v1/users/$userId');
      return Profile.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<Profile> updateProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response =
          await _apiClient.put('/api/v1/users/$userId', data: data);
      return Profile.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }
}
