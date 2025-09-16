import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Apne Node.js server ka base URL
  static const String baseUrl = "http://localhost:5000/api";

  /// Get all batches
  static Future<List<dynamic>> getBatches() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/batches"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load batches");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Add new batch
  static Future<bool> addBatch(String name, int fromYear, int toYear) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/batches"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "from": fromYear,
          "to": toYear,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Update batch
  static Future<bool> updateBatch(
      String id, String name, int fromYear, int toYear) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/batches/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "from": fromYear,
          "to": toYear,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  /// Delete batch
  static Future<bool> deleteBatch(String id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/batches/$id"));
      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
// // routes/batchRoutes.js
// const express = require("express");
// const router = express.Router();
// const Batch = require("../models/Batch");

// // Get all batches
// router.get("/", async (req, res) => {
//   const batches = await Batch.find();
//   res.json(batches);
// });

// // Add batch
// router.post("/", async (req, res) => {
//   const { name, from, to } = req.body;
//   const newBatch = new Batch({ name, from, to });
//   await newBatch.save();
//   res.status(201).json(newBatch);
// });

// // Update batch
// router.put("/:id", async (req, res) => {
//   const { name, from, to } = req.body;
//   const updated = await Batch.findByIdAndUpdate(
//     req.params.id,
//     { name, from, to },
//     { new: true }
//   );
//   res.json(updated);
// });

// // Delete batch
// router.delete("/:id", async (req, res) => {
//   await Batch.findByIdAndDelete(req.params.id);
//   res.json({ message: "Batch deleted" });
// });

// module.exports = router;
