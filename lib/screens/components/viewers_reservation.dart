import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:fl_chart/fl_chart.dart';

class ViewersReservation extends StatefulWidget {
  const ViewersReservation({Key? key}) : super(key: key);

  @override
  _ViewersState createState() => _ViewersState();
}

class _ViewersState extends State<ViewersReservation> {
  Map<int, int> reservationsPerYear = {};

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

        // Sum the number of reservations per year
        for (final reservation in reservations) {
          final DateTime checkInDate = DateTime.parse(reservation['checkInDate']);
          final int year = checkInDate.year;

          reservationsPerYear.update(year, (value) => value + 1, ifAbsent: () => 1);
        }

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
    return Container(
      height: 350,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reservation per year',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: true),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: reservationsPerYear.keys.isNotEmpty
                    ? reservationsPerYear.keys.reduce((min, year) => year < min ? year : min).toDouble() - 0.5
                    : 0,
                maxX: reservationsPerYear.keys.isNotEmpty
                    ? reservationsPerYear.keys.reduce((max, year) => year > max ? year : max).toDouble() + 0.5
                    : 1,
                minY: 0,
                maxY: reservationsPerYear.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: reservationsPerYear.entries
                        .map(
                          (entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble()),
                        )
                        .toList(),
                    isCurved: true,
                    belowBarData: BarAreaData(show: false),
                    colors: [Colors.blue],
                    barWidth: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
