import 'package:flutter/material.dart';
import 'package:flutter_pharmacies_2023/models/pharmacie.dart';

class DetailsPharmacieEcran extends StatelessWidget {
  final Pharmacie pharmacie;

  DetailsPharmacieEcran({required this.pharmacie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la pharmacie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom: ${pharmacie.nom}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Quartier: ${pharmacie.quartier}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Latitude: ${pharmacie.latitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Longitude: ${pharmacie.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Ajoutez d'autres détails selon vos besoins
          ],
        ),
      ),
    );
  }
}
