/*import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogementsPerYearChart extends StatefulWidget {
  const LogementsPerYearChart({Key? key}) : super(key: key);

  @override
  _LogementsPerYearChartState createState() => _LogementsPerYearChartState();
}

class _LogementsPerYearChartState extends State<LogementsPerYearChart> {
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _fetchDataPoints();
  }

  Future<void> _fetchDataPoints() async {
    try {
      // Fetch Logements data
      final response = await http.get(Uri.parse('http://localhost:3000/api/logements'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final Map<int, int> logementsByYear = {};

        jsonData.forEach((data) {
          // Adaptation en fonction de votre modèle de logement
          final int year = data['annee']; // Remplacez 'annee' par le champ correspondant dans votre modèle
          logementsByYear[year] = (logementsByYear[year] ?? 0) + 1;
        });

        final List<DataPoint> fetchedDataPoints = [];

        // Fill in the data points
        for (int year = DateTime.now().year - 5; year <= DateTime.now().year; year++) {
          fetchedDataPoints.add(DataPoint(
            x: year.toDouble(),
            y: logementsByYear[year]?.toDouble() ?? 0,
          ));
        }

        setState(() {
          dataPoints = fetchedDataPoints;
        });
      } else {
        throw Exception('Failed to load data points');
      }
    } catch (e) {
      print('Error fetching data points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set the desired height
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints.map((dataPoint) {
                return FlSpot(dataPoint.x, dataPoint.y);
              }).toList(),
              isCurved: true,
              colors: [Colors.blue],
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: true),
            ),
          ],
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 0.5,
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 0.5,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return value.toInt().toString(); // Adapté en fonction de vos besoins
              },
              reservedSize: 32,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return value.toInt().toString();
              },
              reservedSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint({required this.x, required this.y});
}
*/