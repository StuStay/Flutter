import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';

class ViewLineChart extends StatefulWidget {
  const ViewLineChart({Key? key}) : super(key: key);

  @override
  _ViewLineChartState createState() => _ViewLineChartState();
}

class _ViewLineChartState extends State<ViewLineChart> {
  List<Color> gradientColors = [
    primaryColor,
    secondaryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        appPadding,
        appPadding * 1.5,
        appPadding,
        appPadding,
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
             getTextStyles: (BuildContext context, double value) => TextStyle(
  color: lightTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 14,
),

              getTitles: (value) {
                return '${value.toInt()}'; // Use the actual day values
              },
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: 20,
          maxY: 10, // Adjusted based on your data
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(1, 3),
                FlSpot(4, 6),
                FlSpot(7, 8),
                FlSpot(10, 4),
                FlSpot(13, 7),
                FlSpot(16, 5),
                FlSpot(19, 9),
              ],
              isCurved: true,
              colors: [primaryColor],
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                gradientFrom: Offset(0, 0),
                gradientTo: Offset(0, 1.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

