// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BuyTicketResponse _$BuyTicketResponseFromJson(Map<String, dynamic> json) =>
    _BuyTicketResponse(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      arrivalTime: DateTime.parse(json['arrivalTime'] as String),
      bookingDate: json['bookingDate'] as String,
      seatNumber: json['seatNumber'] as String,
      qrCodeUrl: json['qrCodeUrl'] as String,
    );

Map<String, dynamic> _$BuyTicketResponseToJson(_BuyTicketResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'origin': instance.origin,
      'destination': instance.destination,
      'departureTime': instance.departureTime.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
      'bookingDate': instance.bookingDate,
      'seatNumber': instance.seatNumber,
      'qrCodeUrl': instance.qrCodeUrl,
    };
