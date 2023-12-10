import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentsPerYearChart extends StatefulWidget {
  const PaymentsPerYearChart({Key? key}) : super(key: key);

  @override
  _PaymentsPerYearChartState createState() => _PaymentsPerYearChartState();
}

class _PaymentsPerYearChartState extends State<PaymentsPerYearChart> {
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    _fetchDataPoints();
  }

  Future<void> _fetchDataPoints() async {
    try {
      // Fetch payments data
      final response = await http.get(Uri.parse('http://192.168.1.3:3000/api/payments'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // Group data by year and count the number of payments
        final Map<int, int> paymentsByYear = {};

        jsonData.forEach((data) {
          int year = _parseDate(data['date']).year;
          paymentsByYear[year] = (paymentsByYear[year] ?? 0) + 1;
        });

        final List<DataPoint> fetchedDataPoints = [];

        // Fill in the data points
        for (int year = DateTime.now().year - 5; year <= DateTime.now().year; year++) {
          fetchedDataPoints.add(DataPoint(
            x: year.toDouble(),
            y: paymentsByYear[year]?.toDouble() ?? 0,
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

  // Convert date string to DateTime
  DateTime _parseDate(String dateString) {
    return DateTime.parse(dateString);
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
