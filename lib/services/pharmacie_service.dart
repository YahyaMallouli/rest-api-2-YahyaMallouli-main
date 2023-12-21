import 'dart:convert';
import 'package:flutter_pharmacies_2023/models/pharmacie.dart';
import 'package:http/http.dart' as http;

class PharmacieService {
  final String baseUrl = 'http://localhost:3000/pharmacies';

  Future<List<Pharmacie>> chargerPharmacies() async {
    try {
      final reponse = await http.get(Uri.parse(baseUrl));

      if (reponse.statusCode == 200) {
        final List<dynamic> donnees = json.decode(reponse.body);

        return donnees.map((json) => Pharmacie.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des pharmacies');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite: $e');
    }
  }

  Future<Pharmacie> creerPharmacie(Pharmacie pharmacie) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pharmacie.toJson()),
      );

      if (response.statusCode == 201) {
        // Successfully created a new pharmacy
        final Map<String, dynamic> responseData = json.decode(response.body);
        return Pharmacie.fromJson(responseData);
      } else {
        throw Exception('Échec de la création de la pharmacie');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la création: $e');
    }
  }

  Future<void> ajouterPharmacie(Pharmacie nouvellePharmacie) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(nouvellePharmacie.toJson()),
      );
      if (response.statusCode == 201) {
        // Successfully added
      } else {
        throw Exception('Failed to add pharmacy');
      }
    } catch (e) {
      throw Exception('Error adding pharmacy: $e');
    }
  }

  Future<void> supprimerPharmacie(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 204) {
        // Successfully deleted the pharmacy
      } else {
        throw Exception('Échec de la suppression de la pharmacie');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la suppression: $e');
    }
  }
}
