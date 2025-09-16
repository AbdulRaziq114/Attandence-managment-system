import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl = "http://localhost:5000/api/students";

  /// Get all students
  static Future<List<dynamic>> getStudents() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) return jsonDecode(res.body);
      throw Exception("Failed to load students");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Add student
  static Future<bool> addStudent(String grNo) async {
    try {
      final res = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"grNo": grNo}),
      );
      return res.statusCode == 201;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Update student
  static Future<bool> updateStudent(String id, String grNo) async {
    try {
      final res = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"grNo": grNo}),
      );
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Delete student
  static Future<bool> deleteStudent(String id) async {
    try {
      final res = await http.delete(Uri.parse("$baseUrl/$id"));
      return res.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
