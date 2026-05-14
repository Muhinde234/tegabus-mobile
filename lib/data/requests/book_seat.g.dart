// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookSeatRequest _$BookSeatRequestFromJson(Map<String, dynamic> json) =>
    _BookSeatRequest(
      seatAvailabilityId: (json['seatAvailabilityId'] as num).toInt(),
      seatNumber: json['seatNumber'] as String,
    );

Map<String, dynamic> _$BookSeatRequestToJson(_BookSeatRequest instance) =>
    <String, dynamic>{
      'seatAvailabilityId': instance.seatAvailabilityId,
      'seatNumber': instance.seatNumber,
    };
