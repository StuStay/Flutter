import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersByDevice extends StatefulWidget {
  @override
  _UsersByDeviceState createState() => _UsersByDeviceState();
}

class _UsersByDeviceState extends State<UsersByDevice> {
  double logementPercentageInf500 = 0.0;
  double logementPercentage500to1000 = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchLogementMethods();
  }

  Future<void> _fetchLogementMethods() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.2:3000/api/logements'));

      if (response.statusCode == 200) {
        final List<dynamic> logementData = json.decode(response.body);
        final int totalLogements = logementData.length;

        int logementAvecPrixInf500 = 0;
        int logementAvecPrix500to1000 = 0;

        logementData.forEach((logement) {
          final int prix = logement['prix'];

          if (prix < 500) {
            logementAvecPrixInf500++;
          } else if (prix >= 500 && prix <= 1000) {
            logementAvecPrix500to1000++;
          }
        });

        logementPercentageInf500 = logementAvecPrixInf500 / totalLogements;
        logementPercentage500to1000 = logementAvecPrix500to1000 / totalLogements;
        setState(() {});
      } else {
        throw Exception('Failed to load Housing methods');
      }
    } catch (e) {
      print('Error fetching Housing methods: $e');
    }
  }

  Widget _buildCircularIndicator(double percentage, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        SizedBox(height: 8),
        Text(
          '${(percentage * 100).toStringAsFixed(2)}%',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCircularIndicator(logementPercentageInf500, 'Less than 500 DT'),
                      _buildCircularIndicator(logementPercentage500to1000, 'Between 500 and 1000 DT'),
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
