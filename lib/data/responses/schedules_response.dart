import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedules_response.freezed.dart';
part 'schedules_response.g.dart';

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    required int id,
    required String bus,
    required double price,
    String? companyId,
    String? companyName,
    String? driverName,
    String? driverPhone,
    required String from,
    required String to,
    required DateTime departureTime,
    required DateTime arrivalTime,
    required int totalSeats,
    required int remainingSeats,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
