// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupUser {

 String get id; String get email; String get fullName; String get role;
/// Create a copy of SignupUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupUserCopyWith<SignupUser> get copyWith => _$SignupUserCopyWithImpl<SignupUser>(this as SignupUser, _$identity);

  /// Serializes this SignupUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,fullName,role);

@override
String toString() {
  return 'SignupUser(id: $id, email: $email, fullName: $fullName, role: $role)';
}


}

/// @nodoc
abstract mixin class $SignupUserCopyWith<$Res>  {
  factory $SignupUserCopyWith(SignupUser value, $Res Function(SignupUser) _then) = _$SignupUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String fullName, String role
});




}
/// @nodoc
class _$SignupUserCopyWithImpl<$Res>
    implements $SignupUserCopyWith<$Res> {
  _$SignupUserCopyWithImpl(this._self, this._then);

  final SignupUser _self;
  final $Res Function(SignupUser) _then;

/// Create a copy of SignupUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? role = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SignupUser implements SignupUser {
  const _SignupUser({required this.id, required this.email, required this.fullName, required this.role});
  factory _SignupUser.fromJson(Map<String, dynamic> json) => _$SignupUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String fullName;
@override final  String role;

/// Create a copy of SignupUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupUserCopyWith<_SignupUser> get copyWith => __$SignupUserCopyWithImpl<_SignupUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,fullName,role);

@override
String toString() {
  return 'SignupUser(id: $id, email: $email, fullName: $fullName, role: $role)';
}


}

/// @nodoc
abstract mixin class _$SignupUserCopyWith<$Res> implements $SignupUserCopyWith<$Res> {
  factory _$SignupUserCopyWith(_SignupUser value, $Res Function(_SignupUser) _then) = __$SignupUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String fullName, String role
});




}
/// @nodoc
class __$SignupUserCopyWithImpl<$Res>
    implements _$SignupUserCopyWith<$Res> {
  __$SignupUserCopyWithImpl(this._self, this._then);

  final _SignupUser _self;
  final $Res Function(_SignupUser) _then;

/// Create a copy of SignupUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? role = null,}) {
  return _then(_SignupUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignupResponse {

 String get message; SignupUser get user;
/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupResponseCopyWith<SignupResponse> get copyWith => _$SignupResponseCopyWithImpl<SignupResponse>(this as SignupResponse, _$identity);

  /// Serializes this SignupResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,user);

@override
String toString() {
  return 'SignupResponse(message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class $SignupResponseCopyWith<$Res>  {
  factory $SignupResponseCopyWith(SignupResponse value, $Res Function(SignupResponse) _then) = _$SignupResponseCopyWithImpl;
@useResult
$Res call({
 String message, SignupUser user
});


$SignupUserCopyWith<$Res> get user;

}
/// @nodoc
class _$SignupResponseCopyWithImpl<$Res>
    implements $SignupResponseCopyWith<$Res> {
  _$SignupResponseCopyWithImpl(this._self, this._then);

  final SignupResponse _self;
  final $Res Function(SignupResponse) _then;

/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? user = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SignupUser,
  ));
}
/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupUserCopyWith<$Res> get user {
  
  return $SignupUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _SignupResponse implements SignupResponse {
  const _SignupResponse({required this.message, required this.user});
  factory _SignupResponse.fromJson(Map<String, dynamic> json) => _$SignupResponseFromJson(json);

@override final  String message;
@override final  SignupUser user;

/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupResponseCopyWith<_SignupResponse> get copyWith => __$SignupResponseCopyWithImpl<_SignupResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupResponse&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,user);

@override
String toString() {
  return 'SignupResponse(message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class _$SignupResponseCopyWith<$Res> implements $SignupResponseCopyWith<$Res> {
  factory _$SignupResponseCopyWith(_SignupResponse value, $Res Function(_SignupResponse) _then) = __$SignupResponseCopyWithImpl;
@override @useResult
$Res call({
 String message, SignupUser user
});


@override $SignupUserCopyWith<$Res> get user;

}
/// @nodoc
class __$SignupResponseCopyWithImpl<$Res>
    implements _$SignupResponseCopyWith<$Res> {
  __$SignupResponseCopyWithImpl(this._self, this._then);

  final _SignupResponse _self;
  final $Res Function(_SignupResponse) _then;

/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? user = null,}) {
  return _then(_SignupResponse(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SignupUser,
  ));
}

/// Create a copy of SignupResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupUserCopyWith<$Res> get user {
  
  return $SignupUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
