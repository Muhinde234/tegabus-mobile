import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_ticket_response.freezed.dart';
part 'my_ticket_response.g.dart';

/// Locally stored ticket (persisted after a successful booking).
@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String origin,
    required String destination,
    required String seatNumber,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required String bookingDate,
    required String qrCodeUrl,
    String? fullName,
    double? price,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) =>
      _$TicketFromJson(json);
}

@freezed
class MyTicketResponse with _$MyTicketResponse {
  const factory MyTicketResponse({
    required List<Ticket> data,
  }) = _MyTicketResponse;

  factory MyTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$MyTicketResponseFromJson(json);
}
