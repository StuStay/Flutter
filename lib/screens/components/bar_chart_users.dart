import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';

class BarChartReclamations extends StatelessWidget {
  const BarChartReclamations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            getTitles: (double value) {
              switch (value.toInt()) {
                case 1:
                  return 'Jan';
                case 2:
                  return 'Feb';
                case 3:
                  return 'Mar';
                case 4:
                  return 'Apr';
                default:
                  return '';
              }
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
              switch (value.toInt()) {
                case 500:
                  return '500';
                case 1000:
                  return '1000';
                case 1500:
                  return '1500';
                default:
                  return '';
              }
            },
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                y: 200,
                width: 20,
                colors: [primaryColor],
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                y: 800,
                width: 20,
                colors: [primaryColor],
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                y: 1200,
                width: 20,
                colors: [primaryColor],
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                y: 600,
                width: 20,
                colors: [primaryColor],
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}