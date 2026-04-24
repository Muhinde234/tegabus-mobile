import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/requests/login_request.dart';
import 'package:mobile/data/requests/sign_up_request.dart';
import 'package:mobile/data/responses/login_response.dart' as lr;
import 'package:mobile/data/responses/profile.dart' as pr;
import 'package:mobile/data/responses/signup_response.dart' as sr;

class AuthService {
  final FlutterSecureStorage _storage;

  AuthService({required ApiClient apiClient}) : _storage = apiClient.storage;

  static const String _mockToken = 'tegabus-mock-token-2026';

  static final lr.User _mockLoginUser = lr.User(
    id: 1,
    firstname: 'Dositha',
    lastname: 'Igirimpuhwe',
    phoneNumber: '+250780123456',
    nationality: 'Rwandan',
    emailVerified: 1,
    emailVerifiedAt: DateTime(2025, 1, 1),
    profilePicUrl: '',
    roles: const ['passenger'],
    permissions: const [],
  );

  Future<sr.SignupResponse> signUp(SignUpRequest request) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final user = sr.User(
      id: 1,
      firstname: request.firstname,
      lastname: request.lastname,
      email: request.email,
      phoneNumber: request.phoneNumber,
      nationality: request.nationality,
      roles: const [sr.Role(id: 1, name: 'passenger')],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return sr.SignupResponse(data: user);
  }

  Future<lr.LoginResponse> login(LoginRequest request) async {
    await Future.delayed(const Duration(milliseconds: 900));
    await _storage.write(key: 'token', value: _mockToken);
    await _storage.write(
      key: 'user_data',
      value: jsonEncode(_mockLoginUser.toJson()),
    );
    return lr.LoginResponse(token: _mockToken, user: _mockLoginUser);
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 400));
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user_data');
  }

  Future<pr.ProfileResponse> me() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return pr.ProfileResponse(
      data: pr.Profile(
        id: 1,
        firstname: 'Dositha',
        lastname: 'Igirimpuhwe',
        email: 'dositha@tegabus.rw',
        profilePicUrl: '',
        phoneNumber: '+250780123456',
        nationality: 'Rwandan',
        roles: const [pr.Role(id: 1, name: 'passenger')],
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      ),
    );
  }
}
