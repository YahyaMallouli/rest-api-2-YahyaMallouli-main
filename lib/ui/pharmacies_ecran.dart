import 'package:flutter/material.dart';
import 'package:flutter_pharmacies_2023/models/pharmacie.dart'; // Importez la classe DetailsPharmacieEcran
import 'package:flutter_pharmacies_2023/services/pharmacie_service.dart';
import 'package:flutter_pharmacies_2023/ui/datailspharmacieecran.dart';

class PharmaciesEcran extends StatefulWidget {
  @override
  _PharmaciesEcranState createState() => _PharmaciesEcranState();
}

class _PharmaciesEcranState extends State<PharmaciesEcran> {
  final PharmacieService pharmacieService = PharmacieService();

  Future<List<Pharmacie>> chargerPharmacies() async {
    try {
      final pharmacies = await pharmacieService.chargerPharmacies();
      return pharmacies;
    } catch (e) {
      throw Exception('Erreur de chargement des pharmacies: $e');
    }
  }

  List<Pharmacie> _pharmacies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des pharmacies'),
      ),
      body: FutureBuilder<List<Pharmacie>>(
        future: chargerPharmacies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Aucune pharmacie disponible.'),
            );
          } else {
            final pharmacies = snapshot.data!;
            return ListView.builder(
              itemCount: pharmacies.length,
              itemBuilder: (context, index) {
                final pharmacie = pharmacies[index];
                return ListTile(
                  title: Text(pharmacie.nom),
                  subtitle: Text(pharmacie.quartier),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Fonction de suppression de la pharmacie
                      try {
                        await pharmacieService.supprimerPharmacie(pharmacie.id);
                        // Rafraîchir la liste après la suppression
                        setState(() {
                          pharmacies.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Pharmacie supprimée avec succès.'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erreur lors de la suppression de la pharmacie: $e'),
                          ),
                        );
                      }
                    },
                  ),
                  onTap: () {
                    // Navigation vers la page de détails de la pharmacie
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPharmacieEcran(pharmacie: pharmacie),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ajout d'une pharmacie (vous pouvez implémenter la logique ici)
          _ajouterPharmacie(context);
        },
        tooltip: 'Ajouter une pharmacie',
        child: Icon(Icons.add),
      ),
    );
  }
}

void _ajouterPharmacie(BuildContext context) {
  TextEditingController nomController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Ajouter une pharmacie'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom de la pharmacie'),
              ),
              TextField(
                controller: quartierController,
                decoration: InputDecoration(labelText: 'Quartier'),
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog without adding the pharmacy
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Create a new Pharmacie instance
                Pharmacie nouvellePharmacie = Pharmacie(
                  nom: nomController.text,
                  quartier: quartierController.text,
                  latitude: double.parse(latitudeController.text),
                  longitude: double.parse(longitudeController.text),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pharmacie ajoutée avec succès.'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur lors de l\'ajout de la pharmacie: $e'),
                  ),
                );
              }

              Navigator.pop(context); // Close the dialog after adding the pharmacy
            },
            child: Text('Ajouter'),
          ),
        ],
      );
    },
  );
}


