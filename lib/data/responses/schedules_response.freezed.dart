// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedules_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Schedule {

 int get id; String get bus; double get price; String? get companyId; String? get companyName; String? get driverName; String? get driverPhone; String get from; String get to; DateTime get departureTime; DateTime get arrivalTime; int get totalSeats; int get remainingSeats;
/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCopyWith<Schedule> get copyWith => _$ScheduleCopyWithImpl<Schedule>(this as Schedule, _$identity);

  /// Serializes this Schedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Schedule&&(identical(other.id, id) || other.id == id)&&(identical(other.bus, bus) || other.bus == bus)&&(identical(other.price, price) || other.price == price)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverPhone, driverPhone) || other.driverPhone == driverPhone)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.remainingSeats, remainingSeats) || other.remainingSeats == remainingSeats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bus,price,companyId,companyName,driverName,driverPhone,from,to,departureTime,arrivalTime,totalSeats,remainingSeats);

@override
String toString() {
  return 'Schedule(id: $id, bus: $bus, price: $price, companyId: $companyId, companyName: $companyName, driverName: $driverName, driverPhone: $driverPhone, from: $from, to: $to, departureTime: $departureTime, arrivalTime: $arrivalTime, totalSeats: $totalSeats, remainingSeats: $remainingSeats)';
}


}

/// @nodoc
abstract mixin class $ScheduleCopyWith<$Res>  {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) _then) = _$ScheduleCopyWithImpl;
@useResult
$Res call({
 int id, String bus, double price, String? companyId, String? companyName, String? driverName, String? driverPhone, String from, String to, DateTime departureTime, DateTime arrivalTime, int totalSeats, int remainingSeats
});




}
/// @nodoc
class _$ScheduleCopyWithImpl<$Res>
    implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._self, this._then);

  final Schedule _self;
  final $Res Function(Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bus = null,Object? price = null,Object? companyId = freezed,Object? companyName = freezed,Object? driverName = freezed,Object? driverPhone = freezed,Object? from = null,Object? to = null,Object? departureTime = null,Object? arrivalTime = null,Object? totalSeats = null,Object? remainingSeats = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bus: null == bus ? _self.bus : bus // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverPhone: freezed == driverPhone ? _self.driverPhone : driverPhone // ignore: cast_nullable_to_non_nullable
as String?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,totalSeats: null == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int,remainingSeats: null == remainingSeats ? _self.remainingSeats : remainingSeats // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Schedule].
extension SchedulePatterns on Schedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Schedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Schedule value)  $default,){
final _that = this;
switch (_that) {
case _Schedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Schedule value)?  $default,){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String bus,  double price,  String? companyId,  String? companyName,  String? driverName,  String? driverPhone,  String from,  String to,  DateTime departureTime,  DateTime arrivalTime,  int totalSeats,  int remainingSeats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.id,_that.bus,_that.price,_that.companyId,_that.companyName,_that.driverName,_that.driverPhone,_that.from,_that.to,_that.departureTime,_that.arrivalTime,_that.totalSeats,_that.remainingSeats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String bus,  double price,  String? companyId,  String? companyName,  String? driverName,  String? driverPhone,  String from,  String to,  DateTime departureTime,  DateTime arrivalTime,  int totalSeats,  int remainingSeats)  $default,) {final _that = this;
switch (_that) {
case _Schedule():
return $default(_that.id,_that.bus,_that.price,_that.companyId,_that.companyName,_that.driverName,_that.driverPhone,_that.from,_that.to,_that.departureTime,_that.arrivalTime,_that.totalSeats,_that.remainingSeats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String bus,  double price,  String? companyId,  String? companyName,  String? driverName,  String? driverPhone,  String from,  String to,  DateTime departureTime,  DateTime arrivalTime,  int totalSeats,  int remainingSeats)?  $default,) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.id,_that.bus,_that.price,_that.companyId,_that.companyName,_that.driverName,_that.driverPhone,_that.from,_that.to,_that.departureTime,_that.arrivalTime,_that.totalSeats,_that.remainingSeats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Schedule implements Schedule {
  const _Schedule({required this.id, required this.bus, required this.price, this.companyId, this.companyName, this.driverName, this.driverPhone, required this.from, required this.to, required this.departureTime, required this.arrivalTime, required this.totalSeats, required this.remainingSeats});
  factory _Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

@override final  int id;
@override final  String bus;
@override final  double price;
@override final  String? companyId;
@override final  String? companyName;
@override final  String? driverName;
@override final  String? driverPhone;
@override final  String from;
@override final  String to;
@override final  DateTime departureTime;
@override final  DateTime arrivalTime;
@override final  int totalSeats;
@override final  int remainingSeats;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCopyWith<_Schedule> get copyWith => __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Schedule&&(identical(other.id, id) || other.id == id)&&(identical(other.bus, bus) || other.bus == bus)&&(identical(other.price, price) || other.price == price)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverPhone, driverPhone) || other.driverPhone == driverPhone)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.totalSeats, totalSeats) || other.totalSeats == totalSeats)&&(identical(other.remainingSeats, remainingSeats) || other.remainingSeats == remainingSeats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bus,price,companyId,companyName,driverName,driverPhone,from,to,departureTime,arrivalTime,totalSeats,remainingSeats);

@override
String toString() {
  return 'Schedule(id: $id, bus: $bus, price: $price, companyId: $companyId, companyName: $companyName, driverName: $driverName, driverPhone: $driverPhone, from: $from, to: $to, departureTime: $departureTime, arrivalTime: $arrivalTime, totalSeats: $totalSeats, remainingSeats: $remainingSeats)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) _then) = __$ScheduleCopyWithImpl;
@override @useResult
$Res call({
 int id, String bus, double price, String? companyId, String? companyName, String? driverName, String? driverPhone, String from, String to, DateTime departureTime, DateTime arrivalTime, int totalSeats, int remainingSeats
});




}
/// @nodoc
class __$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(this._self, this._then);

  final _Schedule _self;
  final $Res Function(_Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bus = null,Object? price = null,Object? companyId = freezed,Object? companyName = freezed,Object? driverName = freezed,Object? driverPhone = freezed,Object? from = null,Object? to = null,Object? departureTime = null,Object? arrivalTime = null,Object? totalSeats = null,Object? remainingSeats = null,}) {
  return _then(_Schedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bus: null == bus ? _self.bus : bus // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,companyId: freezed == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverPhone: freezed == driverPhone ? _self.driverPhone : driverPhone // ignore: cast_nullable_to_non_nullable
as String?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,departureTime: null == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,totalSeats: null == totalSeats ? _self.totalSeats : totalSeats // ignore: cast_nullable_to_non_nullable
as int,remainingSeats: null == remainingSeats ? _self.remainingSeats : remainingSeats // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
