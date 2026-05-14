// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id: json['id'] as String,
  origin: json['origin'] as String,
  destination: json['destination'] as String,
  seatNumber: json['seatNumber'] as String,
  departureTime: DateTime.parse(json['departureTime'] as String),
  arrivalTime:
      json['arrivalTime'] == null
          ? null
          : DateTime.parse(json['arrivalTime'] as String),
  bookingDate: json['bookingDate'] as String,
  qrCodeUrl: json['qrCodeUrl'] as String,
  fullName: json['fullName'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  companyId: json['companyId'] as String?,
  companyName: json['companyName'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id': instance.id,
  'origin': instance.origin,
  'destination': instance.destination,
  'seatNumber': instance.seatNumber,
  'departureTime': instance.departureTime.toIso8601String(),
  'arrivalTime': instance.arrivalTime?.toIso8601String(),
  'bookingDate': instance.bookingDate,
  'qrCodeUrl': instance.qrCodeUrl,
  'fullName': instance.fullName,
  'price': instance.price,
  'companyId': instance.companyId,
  'companyName': instance.companyName,
  'status': instance.status,
};

_MyTicketResponse _$MyTicketResponseFromJson(Map<String, dynamic> json) =>
    _MyTicketResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MyTicketResponseToJson(_MyTicketResponse instance) =>
    <String, dynamic>{'data': instance.data};
