import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://localhost:3000/api";

  static Future<bool> markAttendance(String grNumber) async {
    final url = Uri.parse("$baseUrl/attendance");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"grNumber": grNumber}),
    );

    if (response.statusCode == 200) {
      return true; // Attendance saved
    } else {
      return false; // Error
    }
  }
}
