import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/constants.dart';
import '../../data/radial_painter.dart';

class UsersByDevice extends StatefulWidget {
  @override
  _UsersByDeviceState createState() => _UsersByDeviceState();
}

class _UsersByDeviceState extends State<UsersByDevice> {
  double logementPercentage = 0.0;
  double logementactivePercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchLogementMethods();
  }

  Future<void> _fetchLogementMethods() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/logements'));

      if (response.statusCode == 200) {
      final List<dynamic> logementData = json.decode(response.body);
final int totalLogements = logementData.length;

int logementAvecPrixInferieur500 = 0;
int logementAvecPrixEntre500Et1000 = 0;
int logementAvecPrixSuperieur1000 = 0;

int logementAvecUneChambre = 0;
int logementAvecDeuxChambres = 0;
int logementAvecTroisChambresOuPlus = 0;

// Autres champs à ajouter selon votre modèle Logement
int logementAvecImages = 0;
int logementAvecTitre = 0;
int logementAvecDescription = 0;
int logementAvecNom = 0;
int logementAvecContact = 0;
int logementAvecLieu = 0;

logementData.forEach((logement) {
  final List<dynamic> images = logement['images'];
  final String titre = logement['titre'];
  final String description = logement['description'];
  final String nom = logement['nom'];
  final int nombreChambre = logement['nombreChambre'];
  final int prix = logement['prix'];
  final String contact = logement['contact'];
  final String lieu = logement['lieu'];
  // Ajoutez d'autres champs selon votre modèle Logement

  // Logique pour le champ 'prix'
  if (prix < 500) {
    logementAvecPrixInferieur500++;
  } else if (prix >= 500 && prix <= 1000) {
    logementAvecPrixEntre500Et1000++;
  } else {
    logementAvecPrixSuperieur1000++;
  }

  // Logique pour le champ 'nombreChambre'
  if (nombreChambre == 1) {
    logementAvecUneChambre++;
  } else if (nombreChambre == 2) {
    logementAvecDeuxChambres++;
  } else {
    logementAvecTroisChambresOuPlus++;
  }

  // Logique pour d'autres champs
  if (images.isNotEmpty) {
    logementAvecImages++;
  }

  if (titre.isNotEmpty) {
    logementAvecTitre++;
  }

  if (description.isNotEmpty) {
    logementAvecDescription++;
  }

  if (nom.isNotEmpty) {
    logementAvecNom++;
  }

  if (contact.isNotEmpty) {
    logementAvecContact++;
  }

  if (lieu.isNotEmpty) {
    logementAvecLieu++;
  }
});

logementPercentage = logementAvecPrixInferieur500 / totalLogements;
logementactivePercentage = logementAvecPrixEntre500Et1000 / totalLogements;
        setState(() {});
      } else {
        throw Exception('Failed to load Housing methods');
      }
    } catch (e) {
      print('Error fetching Housing methods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
   return Padding(
    padding: const EdgeInsets.only(top: appPadding),
    child: Container(
      height: 350,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Housing Method',
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: appPadding),
          Expanded(
            child: CustomPaint(
                   foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor1: Colors.grey, // Color for Cash
                  lineColor2: Colors.blue, // Color for Credit Card (changed to blue)
                  percent1: logementPercentage,
                  percent2: logementactivePercentage,
                  width: 18.0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(logementPercentage * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'logement',
                      style: TextStyle(
                        color: textColor.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}
