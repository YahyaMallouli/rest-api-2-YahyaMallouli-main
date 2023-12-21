import 'package:uuid/uuid.dart';

class Pharmacie {
  String id; // Mappé à recordid
  String nom; // Mappé à pharmacie
  String quartier; // Mappé à quartier
  double latitude;
  double longitude;

  Pharmacie({
    String? id,
    required this.nom,
    required this.quartier,
    required this.latitude,
    required this.longitude,
  }) : id = id ?? const Uuid().v4();

  //Ajouter ce qu'il faut pour les conversions JSON: Pharmacie.fromJson et toJson

  factory Pharmacie.fromJson(Map<String, dynamic> json) {
    return Pharmacie(
      id: json['id'],
      nom: json['fields']['pharmacie'],
      quartier: json['fields']['quartier'],
      latitude: double.parse(json['fields']['latitude']),
      longitude: double.parse(json['fields']['longitude']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fields': {
        'pharmacie': nom,
        'quartier': quartier,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    };
  }
}
