import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopReferals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchTopReferalsLogement(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          List<dynamic> TopReferals = snapshot.data!;

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
                      'Top Logements',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: textColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appPadding,
                ),
                for (int i = 0; i < TopReferals.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Logement ${i + 1}: \$${TopReferals[i]['titre'] ?? 0}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'ID: ${TopReferals[i]['_id'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: appPadding,
                      ),
                    ],
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<dynamic>> _fetchTopReferalsLogement() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/logements'));

      if (response.statusCode == 200) {
        final List<dynamic> fetchedLogementsLogement = json.decode(response.body);
        fetchedLogementsLogement.sort((a, b) => (b['titre'] ?? 0).compareTo(a['titre'] ?? 0));
        return fetchedLogementsLogement.take(4).toList();
      } else {
        throw Exception('Failed to load Logements');
      }
    } catch (e) {
      throw Exception('Error fetching Logements: $e');
    }
  }
}
