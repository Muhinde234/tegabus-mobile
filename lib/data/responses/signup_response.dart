import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_response.freezed.dart';
part 'signup_response.g.dart';

@freezed
abstract class SignupUser with _$SignupUser {
  const factory SignupUser({
    required String id,
    required String email,
    required String fullName,
    required String role,
  }) = _SignupUser;

  factory SignupUser.fromJson(Map<String, dynamic> json) =>
      _$SignupUserFromJson(json);
}

@freezed
abstract class SignupResponse with _$SignupResponse {
  const factory SignupResponse({
    required String message,
    required SignupUser user,
  }) = _SignupResponse;

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
