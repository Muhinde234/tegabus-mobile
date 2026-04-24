import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_ticket_response.freezed.dart';
part 'buy_ticket_response.g.dart';

@freezed
class BuyTicketResponse with _$BuyTicketResponse {
  const factory BuyTicketResponse({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String origin,
    required String destination,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required String bookingDate,
    required String seatNumber,
    required String qrCodeUrl,
  }) = _BuyTicketResponse;

  factory BuyTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketResponseFromJson(json);
}
