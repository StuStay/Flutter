import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';

class BarChartUsersReservation extends StatefulWidget {
  const BarChartUsersReservation({Key? key}) : super(key: key);

  @override
  _BarChartUsersState createState() => _BarChartUsersState();
}

class _BarChartUsersState extends State<BarChartUsersReservation> {
  List<Map<String, dynamic>> reservationsByLocation = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.18:3000/api/reservations'));

    if (response.statusCode == 200) {
      try {
        final List<Map<String, dynamic>> reservations =
            (json.decode(response.body) as List<dynamic>)
                .cast<Map<String, dynamic>>();

        // Group reservations by location and calculate the number of reservations per location
        final Map<String, int> reservationsCountByLocation = {};
        for (final reservation in reservations) {
          final String location = reservation['location'] as String;
          reservationsCountByLocation.update(location, (count) => count + 1,
              ifAbsent: () => 1);
        }

        // Convert the map to a list of maps for chart data
        reservationsByLocation = reservationsCountByLocation.entries
            .map((entry) => {'location': entry.key, 'count': entry.value})
            .toList();

        setState(() {});
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
    return SizedBox(
      width: 500, // Adjust the width of the chart container
      height: 80, // Adjust the height of the chart container
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(border: Border.all(width: 0)),
          groupsSpace: 10, // Adjust the space between groups
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: lightTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 10, // Adjust the font size for bottom titles
              ),
              margin: 8, // Use EdgeInsets for spacing/ Adjust the bottom margin
              getTitles: (double value) {
                final index = value.toInt();
                if (index >= 0 && index < reservationsByLocation.length) {
                  return reservationsByLocation[index]['location'] as String;
                } else {
                  return '';
                }
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: lightTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 10, // Adjust the font size for left titles
              ),
              margin: 8, // Adjust the left margin
              getTitles: (double value) {
                final intValue = value.toInt();
                return intValue.isEven ? intValue.toString() : '';
              },
            ),
          ),
          barGroups: List.generate(
            reservationsByLocation.length,
            (index) => BarChartGroupData(
              x: index.toInt(),
              barRods: [
                BarChartRodData(
                  y: (reservationsByLocation[index]['count'] as int).toDouble(),
                  width: 12, // Adjust the width of the bars
                  colors: [primaryColor],
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
