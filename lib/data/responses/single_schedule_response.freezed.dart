// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_schedule_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeatAvailability {

 int get seatId; String get seatNumber; bool get booked; int get version;
/// Create a copy of SeatAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeatAvailabilityCopyWith<SeatAvailability> get copyWith => _$SeatAvailabilityCopyWithImpl<SeatAvailability>(this as SeatAvailability, _$identity);

  /// Serializes this SeatAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeatAvailability&&(identical(other.seatId, seatId) || other.seatId == seatId)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.booked, booked) || other.booked == booked)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seatId,seatNumber,booked,version);

@override
String toString() {
  return 'SeatAvailability(seatId: $seatId, seatNumber: $seatNumber, booked: $booked, version: $version)';
}


}

/// @nodoc
abstract mixin class $SeatAvailabilityCopyWith<$Res>  {
  factory $SeatAvailabilityCopyWith(SeatAvailability value, $Res Function(SeatAvailability) _then) = _$SeatAvailabilityCopyWithImpl;
@useResult
$Res call({
 int seatId, String seatNumber, bool booked, int version
});




}
/// @nodoc
class _$SeatAvailabilityCopyWithImpl<$Res>
    implements $SeatAvailabilityCopyWith<$Res> {
  _$SeatAvailabilityCopyWithImpl(this._self, this._then);

  final SeatAvailability _self;
  final $Res Function(SeatAvailability) _then;

/// Create a copy of SeatAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seatId = null,Object? seatNumber = null,Object? booked = null,Object? version = null,}) {
  return _then(_self.copyWith(
seatId: null == seatId ? _self.seatId : seatId // ignore: cast_nullable_to_non_nullable
as int,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,booked: null == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SeatAvailability].
extension SeatAvailabilityPatterns on SeatAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeatAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeatAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeatAvailability value)  $default,){
final _that = this;
switch (_that) {
case _SeatAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeatAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _SeatAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seatId,  String seatNumber,  bool booked,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeatAvailability() when $default != null:
return $default(_that.seatId,_that.seatNumber,_that.booked,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seatId,  String seatNumber,  bool booked,  int version)  $default,) {final _that = this;
switch (_that) {
case _SeatAvailability():
return $default(_that.seatId,_that.seatNumber,_that.booked,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seatId,  String seatNumber,  bool booked,  int version)?  $default,) {final _that = this;
switch (_that) {
case _SeatAvailability() when $default != null:
return $default(_that.seatId,_that.seatNumber,_that.booked,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeatAvailability implements SeatAvailability {
  const _SeatAvailability({required this.seatId, required this.seatNumber, required this.booked, this.version = 0});
  factory _SeatAvailability.fromJson(Map<String, dynamic> json) => _$SeatAvailabilityFromJson(json);

@override final  int seatId;
@override final  String seatNumber;
@override final  bool booked;
@override@JsonKey() final  int version;

/// Create a copy of SeatAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeatAvailabilityCopyWith<_SeatAvailability> get copyWith => __$SeatAvailabilityCopyWithImpl<_SeatAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeatAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeatAvailability&&(identical(other.seatId, seatId) || other.seatId == seatId)&&(identical(other.seatNumber, seatNumber) || other.seatNumber == seatNumber)&&(identical(other.booked, booked) || other.booked == booked)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seatId,seatNumber,booked,version);

@override
String toString() {
  return 'SeatAvailability(seatId: $seatId, seatNumber: $seatNumber, booked: $booked, version: $version)';
}


}

/// @nodoc
abstract mixin class _$SeatAvailabilityCopyWith<$Res> implements $SeatAvailabilityCopyWith<$Res> {
  factory _$SeatAvailabilityCopyWith(_SeatAvailability value, $Res Function(_SeatAvailability) _then) = __$SeatAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 int seatId, String seatNumber, bool booked, int version
});




}
/// @nodoc
class __$SeatAvailabilityCopyWithImpl<$Res>
    implements _$SeatAvailabilityCopyWith<$Res> {
  __$SeatAvailabilityCopyWithImpl(this._self, this._then);

  final _SeatAvailability _self;
  final $Res Function(_SeatAvailability) _then;

/// Create a copy of SeatAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seatId = null,Object? seatNumber = null,Object? booked = null,Object? version = null,}) {
  return _then(_SeatAvailability(
seatId: null == seatId ? _self.seatId : seatId // ignore: cast_nullable_to_non_nullable
as int,seatNumber: null == seatNumber ? _self.seatNumber : seatNumber // ignore: cast_nullable_to_non_nullable
as String,booked: null == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScheduleSeats {

 List<SeatAvailability> get seats;
/// Create a copy of ScheduleSeats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleSeatsCopyWith<ScheduleSeats> get copyWith => _$ScheduleSeatsCopyWithImpl<ScheduleSeats>(this as ScheduleSeats, _$identity);

  /// Serializes this ScheduleSeats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleSeats&&const DeepCollectionEquality().equals(other.seats, seats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(seats));

@override
String toString() {
  return 'ScheduleSeats(seats: $seats)';
}


}

/// @nodoc
abstract mixin class $ScheduleSeatsCopyWith<$Res>  {
  factory $ScheduleSeatsCopyWith(ScheduleSeats value, $Res Function(ScheduleSeats) _then) = _$ScheduleSeatsCopyWithImpl;
@useResult
$Res call({
 List<SeatAvailability> seats
});




}
/// @nodoc
class _$ScheduleSeatsCopyWithImpl<$Res>
    implements $ScheduleSeatsCopyWith<$Res> {
  _$ScheduleSeatsCopyWithImpl(this._self, this._then);

  final ScheduleSeats _self;
  final $Res Function(ScheduleSeats) _then;

/// Create a copy of ScheduleSeats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seats = null,}) {
  return _then(_self.copyWith(
seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as List<SeatAvailability>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleSeats].
extension ScheduleSeatsPatterns on ScheduleSeats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleSeats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleSeats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleSeats value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleSeats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleSeats value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleSeats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SeatAvailability> seats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleSeats() when $default != null:
return $default(_that.seats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SeatAvailability> seats)  $default,) {final _that = this;
switch (_that) {
case _ScheduleSeats():
return $default(_that.seats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SeatAvailability> seats)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleSeats() when $default != null:
return $default(_that.seats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleSeats implements ScheduleSeats {
  const _ScheduleSeats({required final  List<SeatAvailability> seats}): _seats = seats;
  factory _ScheduleSeats.fromJson(Map<String, dynamic> json) => _$ScheduleSeatsFromJson(json);

 final  List<SeatAvailability> _seats;
@override List<SeatAvailability> get seats {
  if (_seats is EqualUnmodifiableListView) return _seats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seats);
}


/// Create a copy of ScheduleSeats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleSeatsCopyWith<_ScheduleSeats> get copyWith => __$ScheduleSeatsCopyWithImpl<_ScheduleSeats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleSeatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleSeats&&const DeepCollectionEquality().equals(other._seats, _seats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_seats));

@override
String toString() {
  return 'ScheduleSeats(seats: $seats)';
}


}

/// @nodoc
abstract mixin class _$ScheduleSeatsCopyWith<$Res> implements $ScheduleSeatsCopyWith<$Res> {
  factory _$ScheduleSeatsCopyWith(_ScheduleSeats value, $Res Function(_ScheduleSeats) _then) = __$ScheduleSeatsCopyWithImpl;
@override @useResult
$Res call({
 List<SeatAvailability> seats
});




}
/// @nodoc
class __$ScheduleSeatsCopyWithImpl<$Res>
    implements _$ScheduleSeatsCopyWith<$Res> {
  __$ScheduleSeatsCopyWithImpl(this._self, this._then);

  final _ScheduleSeats _self;
  final $Res Function(_ScheduleSeats) _then;

/// Create a copy of ScheduleSeats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seats = null,}) {
  return _then(_ScheduleSeats(
seats: null == seats ? _self._seats : seats // ignore: cast_nullable_to_non_nullable
as List<SeatAvailability>,
  ));
}


}

// dart format on
