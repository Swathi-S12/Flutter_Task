import 'dart:convert';
import 'package:http/http.dart' as http;
import 'plant.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/plants';

  // Fetch all plants
  static Future<List<Plant>> getPlants() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Plant.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load plants');
    }
  }

  // Add a new plant
  static Future<void> addPlant(Plant plant) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plant.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add plant');
    }
  }

  // Update a plant by ID
  static Future<bool> updatePlant(String id, Plant plant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plant.toJson()),
    );

    return response.statusCode == 200;
  }

  // Delete a plant by ID
  static Future<bool> deletePlant(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    return response.statusCode == 200;
  }
}
