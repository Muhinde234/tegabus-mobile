// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
  id: (json['id'] as num).toInt(),
  bus: json['bus'] as String,
  price: (json['price'] as num).toDouble(),
  driverName: json['driverName'] as String?,
  driverPhone: json['driverPhone'] as String?,
  from: json['from'] as String,
  to: json['to'] as String,
  departureTime: DateTime.parse(json['departureTime'] as String),
  arrivalTime: DateTime.parse(json['arrivalTime'] as String),
  totalSeats: (json['totalSeats'] as num).toInt(),
  remainingSeats: (json['remainingSeats'] as num).toInt(),
);

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
  'id': instance.id,
  'bus': instance.bus,
  'price': instance.price,
  'driverName': instance.driverName,
  'driverPhone': instance.driverPhone,
  'from': instance.from,
  'to': instance.to,
  'departureTime': instance.departureTime.toIso8601String(),
  'arrivalTime': instance.arrivalTime.toIso8601String(),
  'totalSeats': instance.totalSeats,
  'remainingSeats': instance.remainingSeats,
};
