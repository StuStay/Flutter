import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_admin_dashboard/constants/constants_r.dart';

class TopReferalsReservation extends StatefulWidget {
  const TopReferalsReservation({Key? key}) : super(key: key);

  @override
  _TopReferalsState createState() => _TopReferalsState();
}

class _TopReferalsState extends State<TopReferalsReservation> {
  List<Map<String, dynamic>> topStays = [];

  @override
  void initState() {
    super.initState();
    fetchTopStays();
  }

  Future<void> fetchTopStays() async {
    final response = await http.get(Uri.parse('http://192.168.1.18:3000/api/reservations'));

    if (response.statusCode == 200) {
      try {
        final List<Map<String, dynamic>> reservations = (json.decode(response.body) as List<dynamic>)
            .cast<Map<String, dynamic>>();

        // Calculate the duration of stay and sort reservations by duration in descending order
        reservations.sort((a, b) {
          final DateTime checkInA = DateTime.parse(a['checkInDate']);
          final DateTime checkOutA = DateTime.parse(a['checkOutDate']);
          final Duration durationA = checkOutA.difference(checkInA);

          final DateTime checkInB = DateTime.parse(b['checkInDate']);
          final DateTime checkOutB = DateTime.parse(b['checkOutDate']);
          final Duration durationB = checkOutB.difference(checkInB);

          return durationB.compareTo(durationA);
        });

        // Get the top 4 stays with the highest duration and their _id
        topStays = reservations.take(4).map((reservation) {
          final DateTime checkIn = DateTime.parse(reservation['checkInDate']);
          final DateTime checkOut = DateTime.parse(reservation['checkOutDate']);
          final Duration duration = checkOut.difference(checkIn);

          return {
            '_id': reservation['_id'],
            'duration': duration.inDays,
          };
        }).toList();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Duration of Stay',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: topStays.length,
              itemBuilder: (context, index) => ListTile(
                title: Text('Reservation ID: ${topStays[index]['_id']}'),
                subtitle: Text('Duration: ${topStays[index]['duration']} days'),
                // Other ListTile properties...
              ),
            ),
          )
        ],
      ),
    );
  }
}
