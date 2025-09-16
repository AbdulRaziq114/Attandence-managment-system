// lib/services/timetable_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TimetableService {
  static const String baseUrl = "http://localhost:5000/api/timetable"; // apne backend ka URL yaha dalna

  /// Get all timetables
  static Future<List<dynamic>> fetchTimetables() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load timetables");
    }
  }

  /// Create new timetable
  static Future<Map<String, dynamic>> createTimetable(Map<String, dynamic> timetable) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(timetable),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create timetable");
    }
  }

  /// Update timetable
  static Future<Map<String, dynamic>> updateTimetable(String id, Map<String, dynamic> timetable) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(timetable),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to update timetable");
    }
  }

  /// Delete timetable
  static Future<void> deleteTimetable(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete timetable");
    }
  }
}
// await TimetableService.fetchTimetables();
// await TimetableService.createTimetable(data);
// await TimetableService.updateTimetable(id, data);
// await TimetableService.deleteTimetable(id);
