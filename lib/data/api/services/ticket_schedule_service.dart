import 'package:mobile/data/api/api_client.dart';
import 'package:mobile/data/responses/buy_ticket_response.dart';
import 'package:mobile/data/responses/schedules_response.dart';
import 'package:mobile/data/responses/single_schedule_response.dart';

class TicketScheduleService {
  final ApiClient _apiClient;

  TicketScheduleService({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<Schedule>> getAllSchedules({
    String? from,
    String? to,
    String? departureDate,
  }) async {
    try {
      final response = await _apiClient.get('/api/v1/schedules', params: {
        if (from != null && from.isNotEmpty) 'from': from,
        if (to != null && to.isNotEmpty) 'to': to,
        if (departureDate != null && departureDate.isNotEmpty)
          'departureDate': departureDate,
      });
      final list = response.data as List<dynamic>;
      return list
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<ScheduleSeats> getScheduleSeats(int scheduleId) async {
    try {
      final response =
          await _apiClient.get('/api/v1/schedules/$scheduleId/seats');
      return ScheduleSeats.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<BuyTicketResponse> buyTicket(int scheduleId, int seatId) async {
    try {
      final response = await _apiClient.post('/api/v1/bookings', data: {
        'scheduleId': scheduleId,
        'seatId': seatId,
      });
      return BuyTicketResponse.fromJson(
          response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<List<String>> getOrigins() async {
    try {
      final response =
          await _apiClient.get('/api/v1/routes/start-locations');
      return List<String>.from(response.data as List);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<List<String>> getDestinations() async {
    try {
      final response =
          await _apiClient.get('/api/v1/routes/end-locations');
      return List<String>.from(response.data as List);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<List<String>> getDestinationsFor(String start) async {
    try {
      final response = await _apiClient
          .get('/api/v1/routes/$start/end-locations');
      return List<String>.from(response.data as List);
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }

  Future<String> sendChatMessage(String message) async {
    try {
      final response = await _apiClient.post('/api/v1/ai/chat', data: {
        'message': message,
      });
      final data = response.data as Map<String, dynamic>;
      return data['message']?.toString() ??
          data['response']?.toString() ??
          'No response';
    } catch (e) {
      throw Exception(ApiClient.extractError(e));
    }
  }
}
