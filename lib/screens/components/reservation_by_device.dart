import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/screens/components/radial_painter_reservation.dart';

class ReservationByDevice extends StatefulWidget {
  const ReservationByDevice({Key? key}) : super(key: key);

  @override
  _UsersByDeviceState createState() => _UsersByDeviceState();
}

class _UsersByDeviceState extends State<ReservationByDevice> {
  double dishwasherPercentage = 0.0;

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

        // Calculate the percentage of reservations with DISHWASHER
        final int totalReservations = reservations.length;
        final int dishwasherReservations = reservations.where((reservation) {
          final List<dynamic>? features = reservation['features'];
          return features?.contains('DISHWASHER') ?? false;
        }).length;

        setState(() {
          dishwasherPercentage = totalReservations > 0 ? dishwasherReservations / totalReservations : 0.0;
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
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dishwasher Usage',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: 230,
              child: CustomPaint(
                foregroundPainter: RadialPainterReservation(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor: primaryColor,
                  percent: dishwasherPercentage,
                  width: 18.0,
                ),
                child: Center(
                  child: Text(
                    '${(dishwasherPercentage * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: primaryColor,
                        size: 10,
                      ),
                      SizedBox(
                        width: appPadding / 2,
                      ),
                      Text(
                        'With Dishwasher',
                        style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: textColor.withOpacity(0.2),
                        size: 10,
                      ),
                      SizedBox(
                        width: appPadding / 2,
                      ),
                      Text(
                        'Without Dishwasher',
                        style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
