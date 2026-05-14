// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_ticket_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ticket {

 String get id; String get origin; String get destination; String get seatNumber; DateTime get departureTime; DateTime? get arrivalTime; String get bookingDate; String get qrCodeUrl; String? get fullName; double? get price; String? get companyId; String? get companyName; String? get status;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.price, price) || other.price == price)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,origin,destination,seatNumber,departureTime,arrivalTime,bookingDate,qrCodeUrl,fullName,price,companyId,companyName,status);

@override
String toString() {
  return 'Ticket(id: $id, origin: $origin, destination: $destination, seatNumber: $seatNumber, departureTime: $departureTime, arrivalTime: $arrivalTime, bookingDate: $bookingDate, qrCodeUrl: $qrCodeUrl, fullName: $fullName, price: $price, companyId: $companyId, companyName: $companyName, status: $status)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 String id, String origin, String destination, String seatNumber, DateTime departureTime, DateTime? arrivalTime, String bookingDate, String qrCodeUrl, String? fullName, double? price, String? companyId, String? companyName, String? status
});




}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? origin = null,Object? destination = null,Object? seatNumber = null,Object? departureTime = null,Object? arrivalTime = freezed,Object? bookingDate = null,Object? qrCodeUrl = null,Object? fullName = freezed,Object? price = freezed,Object? companyId = freezed,Object? companyName = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as String,qrCodeUrl: null == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String origin,  String destination,  String seatNumber,  DateTime departureTime,  DateTime? arrivalTime,  String bookingDate,  String qrCodeUrl,  String? fullName,  double? price,  String? companyId,  String? companyName,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.origin,_that.destination,_that.seatNumber,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.qrCodeUrl,_that.fullName,_that.price,_that.companyId,_that.companyName,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String origin,  String destination,  String seatNumber,  DateTime departureTime,  DateTime? arrivalTime,  String bookingDate,  String qrCodeUrl,  String? fullName,  double? price,  String? companyId,  String? companyName,  String? status)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.origin,_that.destination,_that.seatNumber,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.qrCodeUrl,_that.fullName,_that.price,_that.companyId,_that.companyName,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String origin,  String destination,  String seatNumber,  DateTime departureTime,  DateTime? arrivalTime,  String bookingDate,  String qrCodeUrl,  String? fullName,  double? price,  String? companyId,  String? companyName,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.origin,_that.destination,_that.seatNumber,_that.departureTime,_that.arrivalTime,_that.bookingDate,_that.qrCodeUrl,_that.fullName,_that.price,_that.companyId,_that.companyName,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket implements Ticket {
  const _Ticket({required this.id, required this.origin, required this.destination, required this.seatNumber, required this.departureTime, this.arrivalTime, required this.bookingDate, required this.qrCodeUrl, this.fullName, this.price, this.companyId, this.companyName, this.status});
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override final  String id;
@override final  String origin;
@override final  String destination;
@override final  String seatNumber;
@override final  DateTime departureTime;
@override final  DateTime? arrivalTime;
@override final  String bookingDate;
@override final  String qrCodeUrl;
@override final  String? fullName;
@override final  double? price;
@override final  String? companyId;
@override final  String? companyName;
@override final  String? status;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.bookingDate, bookingDate) || other.bookingDate == bookingDate)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.price, price) || other.price == price)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,origin,destination,seatNumber,departureTime,arrivalTime,bookingDate,qrCodeUrl,fullName,price,companyId,companyName,status);

@override
String toString() {
  return 'Ticket(id: $id, origin: $origin, destination: $destination, seatNumber: $seatNumber, departureTime: $departureTime, arrivalTime: $arrivalTime, bookingDate: $bookingDate, qrCodeUrl: $qrCodeUrl, fullName: $fullName, price: $price, companyId: $companyId, companyName: $companyName, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 String id, String origin, String destination, String seatNumber, DateTime departureTime, DateTime? arrivalTime, String bookingDate, String qrCodeUrl, String? fullName, double? price, String? companyId, String? companyName, String? status
});




}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? origin = null,Object? destination = null,Object? seatNumber = null,Object? departureTime = null,Object? arrivalTime = freezed,Object? bookingDate = null,Object? qrCodeUrl = null,Object? fullName = freezed,Object? price = freezed,Object? companyId = freezed,Object? companyName = freezed,Object? status = freezed,}) {
  return _then(_Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,bookingDate: null == bookingDate ? _self.bookingDate : bookingDate // ignore: cast_nullable_to_non_nullable
as String,qrCodeUrl: null == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MyTicketResponse {

 List<Ticket> get data;
/// Create a copy of MyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyTicketResponseCopyWith<MyTicketResponse> get copyWith => _$MyTicketResponseCopyWithImpl<MyTicketResponse>(this as MyTicketResponse, _$identity);

  /// Serializes this MyTicketResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyTicketResponse&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'MyTicketResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $MyTicketResponseCopyWith<$Res>  {
  factory $MyTicketResponseCopyWith(MyTicketResponse value, $Res Function(MyTicketResponse) _then) = _$MyTicketResponseCopyWithImpl;
@useResult
$Res call({
 List<Ticket> data
});




}
/// @nodoc
class _$MyTicketResponseCopyWithImpl<$Res>
    implements $MyTicketResponseCopyWith<$Res> {
  _$MyTicketResponseCopyWithImpl(this._self, this._then);

  final MyTicketResponse _self;
  final $Res Function(MyTicketResponse) _then;

/// Create a copy of MyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<Ticket>,
  ));
}

}


/// Adds pattern-matching-related methods to [MyTicketResponse].
extension MyTicketResponsePatterns on MyTicketResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyTicketResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyTicketResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyTicketResponse value)  $default,){
final _that = this;
switch (_that) {
case _MyTicketResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyTicketResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MyTicketResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Ticket> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyTicketResponse() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Ticket> data)  $default,) {final _that = this;
switch (_that) {
case _MyTicketResponse():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Ticket> data)?  $default,) {final _that = this;
switch (_that) {
case _MyTicketResponse() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyTicketResponse implements MyTicketResponse {
  const _MyTicketResponse({required final  List<Ticket> data}): _data = data;
  factory _MyTicketResponse.fromJson(Map<String, dynamic> json) => _$MyTicketResponseFromJson(json);

 final  List<Ticket> _data;
@override List<Ticket> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of MyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyTicketResponseCopyWith<_MyTicketResponse> get copyWith => __$MyTicketResponseCopyWithImpl<_MyTicketResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyTicketResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyTicketResponse&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'MyTicketResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$MyTicketResponseCopyWith<$Res> implements $MyTicketResponseCopyWith<$Res> {
  factory _$MyTicketResponseCopyWith(_MyTicketResponse value, $Res Function(_MyTicketResponse) _then) = __$MyTicketResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Ticket> data
});




}
/// @nodoc
class __$MyTicketResponseCopyWithImpl<$Res>
    implements _$MyTicketResponseCopyWith<$Res> {
  __$MyTicketResponseCopyWithImpl(this._self, this._then);

  final _MyTicketResponse _self;
  final $Res Function(_MyTicketResponse) _then;

/// Create a copy of MyTicketResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_MyTicketResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<Ticket>,
  ));
}


}

// dart format on
