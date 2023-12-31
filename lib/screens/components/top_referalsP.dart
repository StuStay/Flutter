import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopReferalsP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchTopPayments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          List<dynamic> topPayments = snapshot.data!;

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
                      'Top Amounts',
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
                for (int i = 0; i < topPayments.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount ${i + 1}: \$${topPayments[i]['amount'] ?? 0}',
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
                        'ID: ${topPayments[i]['_id'] ?? 'N/A'}',
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

  Future<List<dynamic>> _fetchTopPayments() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.6:3000/api/payments'));

      if (response.statusCode == 200) {
        final List<dynamic> fetchedPayments = json.decode(response.body);
        fetchedPayments.sort((a, b) => (b['amount'] ?? 0).compareTo(a['amount'] ?? 0));
        return fetchedPayments.take(4).toList();
      } else {
        throw Exception('Failed to load payments');
      }
    } catch (e) {
      throw Exception('Error fetching payments: $e');
    }
  }
}
