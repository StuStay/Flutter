

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogementList extends StatefulWidget {
  @override
  _LogementListState createState() => _LogementListState();
}

class _LogementListState extends State<LogementList> {
  List<dynamic> logements = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchLogements();
  }

  Future<void> _fetchLogements() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(Uri.parse('http://localhost:3000/api/logements'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedLogements = json.decode(response.body);
      setState(() {
        logements = fetchedLogements;
      });
    } else {
      throw Exception('Failed to load Logements');
    }
  } catch (e) {
    setState(() {
      errorMessage = 'Error fetching Logements: $e';
    });
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  Future<void> _deleteLogement(String logementId, int logementIndex) async {
  try {
    if (logementIndex >= 0 && logementIndex < logements.length) {
      final response = await http.delete(Uri.parse('http://localhost:3000/api/logements/$logementId'));

      if (response.statusCode == 200) {
        setState(() {
          logements.removeAt(logementIndex);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logement deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Failed to delete logement');
      }
    } else {
      throw RangeError('Index out of range');
    }
  } catch (e) {
    print('Error deleting logement: $e');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error deleting logement'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}



  Widget _buildYearHeader(int year) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.blue,
      child: Text(
        'Year $year',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

 Widget _buildLogementItem(BuildContext context, int index, double prix, String nom, String lieu) {
  return ListTile(
    title: Text('Logement #$index'),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prix: \$${prix.toStringAsFixed(2)}', style: TextStyle(color: Colors.cyan)),
        
        Text('Nom: $nom', style: TextStyle(color: Colors.cyan)),
        Text('Lieu: $lieu', style: TextStyle(color: Colors.cyan)),
      ],
    ),
    trailing: IconButton(
      icon: Icon(Icons.delete, color: Colors.cyan),
      onPressed: () async {
        bool deleteConfirmed = await _showDeleteConfirmationDialog(context);
        if (deleteConfirmed) {
          _deleteLogement(logements[index]['_id'], index);
        }
      },
      tooltip: 'Delete logement',
    ),
    onTap: () {
      // Ajoutez ici le code à exécuter lorsqu'un logement est tapé
    },
  );
}

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete logement'),
        content: Text('Are you sure you want to delete this logement?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Close the dialog and return true
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

 

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Logements List'),
      actions: [
        IconButton(
          onPressed: _sortLogementsByYear,
          icon: Icon(Icons.sort),
          tooltip: 'Sort by Year',
        ),
      ],
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
            ? Center(
                child: Text(errorMessage),
              )
            : logements.isEmpty
                ? Center(
                    child: Text('No Logements available'),
                  )
                : AnimatedList(
                    initialItemCount: logements.length,
                    itemBuilder: (context, index, animation) {
                      final logement = logements[index];
                      final prix = logement['prix'];
                        final nom = logement['nom'];
                      final date = DateTime.parse(logement['date']);
                      final lieu = logement['lieu'];

                      bool isNewYear = index == 0 || date.year != DateTime.parse(logements[index - 1]['date']).year;

                      return _buildAnimatedItem(
                        context,
                        index,
                        prix,
                        nom,
                        date,
                        lieu,
                        isNewYear,
                        animation,
                      );
                    },
                  ),
  );
}

Widget _buildAnimatedItem(
  BuildContext context,
  int index,
  double prix,
  String nom,
  DateTime date,
  String lieu,
  bool isNewYear,
  Animation<double> animation,
) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0.0, 0.5),
        end: Offset.zero,
      ).animate(animation),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Column(
            children: [
              if (isNewYear) _buildYearHeader(date.year),
              _buildLogementItem(context, index, prix,nom, lieu),
            ],
          ),
        ),
      ),
    ),
  );
}


  void _sortLogementsByYear() {
    setState(() {
      logements.sort((a, b) => DateTime.parse(b['date']).year.compareTo(DateTime.parse(a['date']).year));
    });
  }
}
