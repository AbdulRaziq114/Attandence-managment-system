import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000/api";

  /// Get all technologies
  static Future<List<dynamic>> getTechnologies() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/technologies"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load technologies");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Add new technology
  static Future<bool> addTechnology(String name) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/technologies"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name}),
      );
      return response.statusCode == 201;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Update technology
  static Future<bool> updateTechnology(String id, String name) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/technologies/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name}),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Delete technology
  static Future<bool> deleteTechnology(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/technologies/$id"));
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
