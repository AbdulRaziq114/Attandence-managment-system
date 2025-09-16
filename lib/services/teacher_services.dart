import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherService {
  static const String baseUrl = "http://localhost:5000/api/teachers";

  /// Get all teachers
  static Future<List<dynamic>> getTeachers() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) return jsonDecode(res.body);
      throw Exception("Failed to load teachers");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Add teacher
  static Future<bool> addTeacher(
      String name, String shift, String password) async {
    try {
      final res = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "shift": shift,
          "password": password,
        }),
      );
      return res.statusCode == 201;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Update teacher
  static Future<bool> updateTeacher(
      String id, String name, String shift, String password) async {
    try {
      final res = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "shift": shift,
          "password": password,
        }),
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Delete teacher
  static Future<bool> deleteTeacher(String id) async {
    try {
      final res = await http.delete(Uri.parse("$baseUrl/$id"));
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
