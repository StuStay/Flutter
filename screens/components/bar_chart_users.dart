import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsive_admin_dashboard/constants/constants.dart';

class BarChartLogements extends StatefulWidget {
  const BarChartLogements({Key? key}) : super(key: key);

  @override
  _BarChartLogementsState createState() => _BarChartLogementsState();
}

class _BarChartLogementsState extends State<BarChartLogements> {
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _fetchDataPoints();
  }

  Future<void> _fetchDataPoints() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.2:3000/api/logements'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final List<DataPoint> fetchedDataPoints = jsonData.map((entry) {
          return DataPoint(
            x: entry.key.toDouble(),
            y: entry.value,
          );
        }).toList();

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
    print(dataPoints); // Print dataPoints to inspect the data

    return BarChart(
      BarChartData(
        borderData: FlBorderData(border: Border.all(width: 0)),
        groupsSpace: 15,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (BuildContext context, double value) => const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 16,
            rotateAngle: -45,
            getTitles: (double value) {
              return value.toInt().toString();
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (BuildContext context, double value) => const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 16,
            getTitles: (double value) {
              if (value % 500 == 0) {
                return '${value.toInt()} TND';
              }
              return '';
            },
          ),
        ),
        barGroups: dataPoints.map((dataPoint) {
          return BarChartGroupData(
            x: dataPoint.x.toInt(),
            barRods: [
              BarChartRodData(
                y: dataPoint.y,
                width: 20,
                colors: [primaryColor],
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint({required this.x, required this.y});
}
