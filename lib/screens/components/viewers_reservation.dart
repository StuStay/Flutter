import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class ViewersReservation extends StatefulWidget {
  const ViewersReservation({Key? key}) : super(key: key);

  @override
  _ViewersState createState() => _ViewersState();
}

class _ViewersState extends State<ViewersReservation> {
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.18:3000/api/reservations'));

    if (response.statusCode == 200) {
      try {
        final List<Map<String, dynamic>> reservations = (json.decode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>();

        final Map<int, int> reservationsPerYear = {};

        // Sum the number of reservations per year
        for (final reservation in reservations) {
          final DateTime checkInDate = DateTime.parse(reservation['checkInDate']);
          final int year = checkInDate.year;

          reservationsPerYear.update(year, (value) => value + 1, ifAbsent: () => 1);
        }

        final List<DataPoint> fetchedDataPoints = [];

        for (int year = DateTime.now().year - 5; year <= DateTime.now().year; year++) {
          fetchedDataPoints.add(DataPoint(
            x: year.toDouble(),
            y: reservationsPerYear[year]?.toDouble() ?? 0,
          ));
        }

        setState(() {
          dataPoints = fetchedDataPoints;
        });
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      // Handle error
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Raw response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
                return value.toInt().toString();
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
