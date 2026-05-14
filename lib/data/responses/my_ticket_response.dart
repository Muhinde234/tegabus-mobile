import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_ticket_response.freezed.dart';
part 'my_ticket_response.g.dart';

/// Locally stored ticket (persisted after a successful booking) or one
/// fetched from `GET /api/v1/tickets/my`. The backend `TicketResponse`
/// doesn't carry every field we'd like to show, so optional fields fall back
/// gracefully.
@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String origin,
    required String destination,
    required String seatNumber,
    required DateTime departureTime,
    DateTime? arrivalTime,
    required String bookingDate,
    required String qrCodeUrl,
    String? fullName,
    double? price,
    String? companyId,
    String? companyName,
    String? status,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) =>
      _$TicketFromJson(json);
}

@freezed
abstract class MyTicketResponse with _$MyTicketResponse {
  const factory MyTicketResponse({
    required List<Ticket> data,
  }) = _MyTicketResponse;

  factory MyTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$MyTicketResponseFromJson(json);
}
