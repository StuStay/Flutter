import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants/constants.dart';
import '../../data/radial_painter.dart';

class UsersByDevice extends StatefulWidget {
  @override
  _UsersByDeviceState createState() => _UsersByDeviceState();
}

class _UsersByDeviceState extends State<UsersByDevice> {
  double cashPercentage = 0.0;
  double creditCardPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  Future<void> _fetchPaymentMethods() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3:3000/api/payments'));

      if (response.statusCode == 200) {
        final List<dynamic> paymentData = json.decode(response.body);
        final int totalPayments = paymentData.length;

        // Count the occurrences of each payment method
        int cashCount = 0;
        int creditCardCount = 0;

        paymentData.forEach((payment) {
          final String method = payment['method'];
          if (method == 'Cash') {
            cashCount++;
          } else if (method == 'credit card') {
            creditCardCount++;
          }
        });

        // Calculate the percentage for each payment method
        cashPercentage = cashCount / totalPayments;
        creditCardPercentage = creditCardCount / totalPayments;

        setState(() {});
      } else {
        throw Exception('Failed to load payment methods');
      }
    } catch (e) {
      print('Error fetching payment methods: $e');
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
              'Payment Method',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: appPadding),
            Expanded(
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor1: Colors.grey, // Color for Cash
                  lineColor2: Colors.blue, // Color for Credit Card (changed to blue)
                  percent1: cashPercentage,
                  percent2: creditCardPercentage,
                  width: 18.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(cashPercentage * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Cash',
                        style: TextStyle(
                          color: textColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: appPadding),
                      Text(
                        '${(creditCardPercentage * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: Colors.blue, // Changed to blue
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Credit Card',
                        style: TextStyle(
                          color: Colors.blue, // Changed to blue
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
