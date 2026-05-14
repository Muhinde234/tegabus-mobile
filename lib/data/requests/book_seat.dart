import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_seat.freezed.dart';
part 'book_seat.g.dart';

@freezed
abstract class BookSeatRequest with _$BookSeatRequest {
  const factory BookSeatRequest({
    required int seatAvailabilityId,
    required String seatNumber,
  }) = _BookSeatRequest;

  factory BookSeatRequest.fromJson(Map<String, dynamic> json) =>
      _$BookSeatRequestFromJson(json);
}
