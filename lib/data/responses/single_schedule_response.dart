import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_schedule_response.freezed.dart';
part 'single_schedule_response.g.dart';

@freezed
abstract class SeatAvailability with _$SeatAvailability {
  const factory SeatAvailability({
    required int seatId,
    required String seatNumber,
    required bool booked,
    @Default(0) int version,
  }) = _SeatAvailability;

  factory SeatAvailability.fromJson(Map<String, dynamic> json) =>
      _$SeatAvailabilityFromJson(json);
}

@freezed
abstract class ScheduleSeats with _$ScheduleSeats {
  const factory ScheduleSeats({
    required List<SeatAvailability> seats,
  }) = _ScheduleSeats;

  factory ScheduleSeats.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSeatsFromJson(json);
}
