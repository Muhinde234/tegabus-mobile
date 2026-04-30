// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_ticket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BuyTicketResponse {

 String get id; String get fullName; String get phoneNumber; String get origin; String get destination; DateTime get departureTime; DateTime get arrivalTime; String get bookingDate; String get seatNumber; String get qrCodeUrl;
/// Create a copy of BuyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyTicketResponseCopyWith<BuyTicketResponse> get copyWith => _$BuyTicketResponseCopyWithImpl<BuyTicketResponse>(this as BuyTicketResponse, _$identity);

  /// Serializes this BuyTicketResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyTicketResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phoneNumber,origin,destination,departureTime,arrivalTime,bookingDate,seatNumber,qrCodeUrl);

@override
String toString() {
  return 'BuyTicketResponse(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, origin: $origin, destination: $destination, departureTime: $departureTime, arrivalTime: $arrivalTime, bookingDate: $bookingDate, seatNumber: $seatNumber, qrCodeUrl: $qrCodeUrl)';
}


}

/// @nodoc
abstract mixin class $BuyTicketResponseCopyWith<$Res>  {
  factory $BuyTicketResponseCopyWith(BuyTicketResponse value, $Res Function(BuyTicketResponse) _then) = _$BuyTicketResponseCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String phoneNumber, String origin, String destination, DateTime departureTime, DateTime arrivalTime, String bookingDate, String seatNumber, String qrCodeUrl
});




}
/// @nodoc
class _$BuyTicketResponseCopyWithImpl<$Res>
    implements $BuyTicketResponseCopyWith<$Res> {
  _$BuyTicketResponseCopyWithImpl(this._self, this._then);

  final BuyTicketResponse _self;
  final $Res Function(BuyTicketResponse) _then;

/// Create a copy of BuyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phoneNumber = null,Object? origin = null,Object? destination = null,Object? departureTime = null,Object? arrivalTime = null,Object? bookingDate = null,Object? seatNumber = null,Object? qrCodeUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as String,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,qrCodeUrl: null == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyTicketResponse].
extension BuyTicketResponsePatterns on BuyTicketResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyTicketResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyTicketResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyTicketResponse value)  $default,){
final _that = this;
switch (_that) {
case _BuyTicketResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyTicketResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BuyTicketResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String phoneNumber,  String origin,  String destination,  DateTime departureTime,  DateTime arrivalTime,  String bookingDate,  String seatNumber,  String qrCodeUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyTicketResponse() when $default != null:
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.origin,_that.destination,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.seatNumber,_that.qrCodeUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String phoneNumber,  String origin,  String destination,  DateTime departureTime,  DateTime arrivalTime,  String bookingDate,  String seatNumber,  String qrCodeUrl)  $default,) {final _that = this;
switch (_that) {
case _BuyTicketResponse():
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.origin,_that.destination,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.seatNumber,_that.qrCodeUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String phoneNumber,  String origin,  String destination,  DateTime departureTime,  DateTime arrivalTime,  String bookingDate,  String seatNumber,  String qrCodeUrl)?  $default,) {final _that = this;
switch (_that) {
case _BuyTicketResponse() when $default != null:
return $default(_that.id,_that.fullName,_that.phoneNumber,_that.origin,_that.destination,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.seatNumber,_that.qrCodeUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuyTicketResponse implements BuyTicketResponse {
  const _BuyTicketResponse({required this.id, required this.fullName, required this.phoneNumber, required this.origin, required this.destination, required this.departureTime, required this.arrivalTime, required this.bookingDate, required this.seatNumber, required this.qrCodeUrl});
  factory _BuyTicketResponse.fromJson(Map<String, dynamic> json) => _$BuyTicketResponseFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String phoneNumber;
@override final  String origin;
@override final  String destination;
@override final  DateTime departureTime;
@override final  DateTime arrivalTime;
@override final  String bookingDate;
@override final  String seatNumber;
@override final  String qrCodeUrl;

/// Create a copy of BuyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyTicketResponseCopyWith<_BuyTicketResponse> get copyWith => __$BuyTicketResponseCopyWithImpl<_BuyTicketResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuyTicketResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyTicketResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,phoneNumber,origin,destination,departureTime,arrivalTime,bookingDate,seatNumber,qrCodeUrl);

@override
String toString() {
  return 'BuyTicketResponse(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, origin: $origin, destination: $destination, departureTime: $departureTime, arrivalTime: $arrivalTime, bookingDate: $bookingDate, seatNumber: $seatNumber, qrCodeUrl: $qrCodeUrl)';
}


}

/// @nodoc
abstract mixin class _$BuyTicketResponseCopyWith<$Res> implements $BuyTicketResponseCopyWith<$Res> {
  factory _$BuyTicketResponseCopyWith(_BuyTicketResponse value, $Res Function(_BuyTicketResponse) _then) = __$BuyTicketResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String phoneNumber, String origin, String destination, DateTime departureTime, DateTime arrivalTime, String bookingDate, String seatNumber, String qrCodeUrl
});




}
/// @nodoc
class __$BuyTicketResponseCopyWithImpl<$Res>
    implements _$BuyTicketResponseCopyWith<$Res> {
  __$BuyTicketResponseCopyWithImpl(this._self, this._then);

  final _BuyTicketResponse _self;
  final $Res Function(_BuyTicketResponse) _then;

/// Create a copy of BuyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phoneNumber = null,Object? origin = null,Object? destination = null,Object? departureTime = null,Object? arrivalTime = null,Object? bookingDate = null,Object? seatNumber = null,Object? qrCodeUrl = null,}) {
  return _then(_BuyTicketResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as String,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,qrCodeUrl: null == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
