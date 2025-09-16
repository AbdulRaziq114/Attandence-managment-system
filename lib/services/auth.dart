import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://localhost:5000/api/auth";

  /// Student SignUp
  static Future<bool> studentSignUp({
    required String name,
    required String surname,
    required String grNumber,
    required String technology,
    required String batch,
    required String mobile,
    required String shift,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/student/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "surname": surname,
          "grNumber": grNumber,
          "technology": technology,
          "batch": batch,
          "mobile": mobile,
          "shift": shift,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Student Login
  static Future<bool> studentLogin({
    required String name,
    required String grNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/student/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "grNumber": grNumber,
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Teacher/Admin Login
  static Future<bool> loginUser({
    required String username,
    required String password,
    required String role, // "teacher" or "admin"
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$role/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
