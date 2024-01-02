import 'package:fl_chart/fl_chart.dart';
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
