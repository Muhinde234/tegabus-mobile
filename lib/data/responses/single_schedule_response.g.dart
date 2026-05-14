// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeatAvailability _$SeatAvailabilityFromJson(Map<String, dynamic> json) =>
    _SeatAvailability(
      seatId: (json['seatId'] as num).toInt(),
      seatNumber: json['seatNumber'] as String,
      booked: json['booked'] as bool,
      locked: json['locked'] as bool? ?? false,
      version: (json['version'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SeatAvailabilityToJson(_SeatAvailability instance) =>
    <String, dynamic>{
      'seatId': instance.seatId,
      'seatNumber': instance.seatNumber,
      'booked': instance.booked,
      'locked': instance.locked,
      'version': instance.version,
    };

_ScheduleSeats _$ScheduleSeatsFromJson(Map<String, dynamic> json) =>
    _ScheduleSeats(
      seats:
          (json['seats'] as List<dynamic>)
              .map((e) => SeatAvailability.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ScheduleSeatsToJson(_ScheduleSeats instance) =>
    <String, dynamic>{'seats': instance.seats};
