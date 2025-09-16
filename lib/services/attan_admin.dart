import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:3000/api";

  static Future<List<dynamic>> getFilteredAttendance({
    String? batch,
    String? technology,
    String? shift,
    String? year,
    String? month,
    String? date,
    String? grNumber,
  }) async {
    final url = Uri.parse("$baseUrl/attendance/filter");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "batch": batch,
        "technology": technology,
        "shift": shift,
        "year": year,
        "month": month,
        "date": date,
        "grNumber": grNumber,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // list of attendance
    } else {
      throw Exception("Failed to fetch attendance");
    }
  }
}
