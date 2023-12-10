import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/constants.dart';

class BarChartPayments extends StatefulWidget {
  const BarChartPayments({Key? key}) : super(key: key);

  @override
  _BarChartPaymentsState createState() => _BarChartPaymentsState();
}

class _BarChartPaymentsState extends State<BarChartPayments> {
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _fetchDataPoints();
  }

  Future<void> _fetchDataPoints() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:3000/api/payments'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // Group data by year and sum amounts
        final Map<int, double> amountsByYear = {};

        jsonData.forEach((data) {
          int year = _parseDate(data['date']).year;
          amountsByYear[year] = (amountsByYear[year] ?? 0) + data['amount'].toDouble();
        });

        final List<DataPoint> fetchedDataPoints = amountsByYear.entries.map((entry) {
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

  // Convert date string to DateTime
  DateTime _parseDate(String dateString) {
    return DateTime.parse(dateString);
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
            getTextStyles: (value) => const TextStyle(
              color: lightTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: appPadding,
            rotateAngle: -45,
            getTitles: (double value) {
              return value.toInt().toString();
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: lightTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: appPadding,
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
  final double x; // Assuming 'x' represents the year
  final double y; // Assuming 'y' represents the total amount for the year

  DataPoint({required this.x, required this.y});
}
