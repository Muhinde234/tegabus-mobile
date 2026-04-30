// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyTicketRequest {

 String get encryptedTicket;
/// Create a copy of VerifyTicketRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyTicketRequestCopyWith<VerifyTicketRequest> get copyWith => _$VerifyTicketRequestCopyWithImpl<VerifyTicketRequest>(this as VerifyTicketRequest, _$identity);

  /// Serializes this VerifyTicketRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyTicketRequest&&(identical(other.encryptedTicket, encryptedTicket) || other.encryptedTicket == encryptedTicket));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,encryptedTicket);

@override
String toString() {
  return 'VerifyTicketRequest(encryptedTicket: $encryptedTicket)';
}


}

/// @nodoc
abstract mixin class $VerifyTicketRequestCopyWith<$Res>  {
  factory $VerifyTicketRequestCopyWith(VerifyTicketRequest value, $Res Function(VerifyTicketRequest) _then) = _$VerifyTicketRequestCopyWithImpl;
@useResult
$Res call({
 String encryptedTicket
});




}
/// @nodoc
class _$VerifyTicketRequestCopyWithImpl<$Res>
    implements $VerifyTicketRequestCopyWith<$Res> {
  _$VerifyTicketRequestCopyWithImpl(this._self, this._then);

  final VerifyTicketRequest _self;
  final $Res Function(VerifyTicketRequest) _then;

/// Create a copy of VerifyTicketRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? encryptedTicket = null,}) {
  return _then(_self.copyWith(
encryptedTicket: null == encryptedTicket ? _self.encryptedTicket : encryptedTicket // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyTicketRequest].
extension VerifyTicketRequestPatterns on VerifyTicketRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyTicketRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyTicketRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyTicketRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyTicketRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyTicketRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyTicketRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String encryptedTicket)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyTicketRequest() when $default != null:
return $default(_that.encryptedTicket);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String encryptedTicket)  $default,) {final _that = this;
switch (_that) {
case _VerifyTicketRequest():
return $default(_that.encryptedTicket);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String encryptedTicket)?  $default,) {final _that = this;
switch (_that) {
case _VerifyTicketRequest() when $default != null:
return $default(_that.encryptedTicket);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyTicketRequest implements VerifyTicketRequest {
  const _VerifyTicketRequest({required this.encryptedTicket});
  factory _VerifyTicketRequest.fromJson(Map<String, dynamic> json) => _$VerifyTicketRequestFromJson(json);

@override final  String encryptedTicket;

/// Create a copy of VerifyTicketRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyTicketRequestCopyWith<_VerifyTicketRequest> get copyWith => __$VerifyTicketRequestCopyWithImpl<_VerifyTicketRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyTicketRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyTicketRequest&&(identical(other.encryptedTicket, encryptedTicket) || other.encryptedTicket == encryptedTicket));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,encryptedTicket);

@override
String toString() {
  return 'VerifyTicketRequest(encryptedTicket: $encryptedTicket)';
}


}

/// @nodoc
abstract mixin class _$VerifyTicketRequestCopyWith<$Res> implements $VerifyTicketRequestCopyWith<$Res> {
  factory _$VerifyTicketRequestCopyWith(_VerifyTicketRequest value, $Res Function(_VerifyTicketRequest) _then) = __$VerifyTicketRequestCopyWithImpl;
@override @useResult
$Res call({
 String encryptedTicket
});




}
/// @nodoc
class __$VerifyTicketRequestCopyWithImpl<$Res>
    implements _$VerifyTicketRequestCopyWith<$Res> {
  __$VerifyTicketRequestCopyWithImpl(this._self, this._then);

  final _VerifyTicketRequest _self;
  final $Res Function(_VerifyTicketRequest) _then;

/// Create a copy of VerifyTicketRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? encryptedTicket = null,}) {
  return _then(_VerifyTicketRequest(
encryptedTicket: null == encryptedTicket ? _self.encryptedTicket : encryptedTicket // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
