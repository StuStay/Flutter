import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';

import 'bar_chart_usersP.dart';

class UsersP extends StatelessWidget {
  const UsersP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Number of Payments ",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
          Expanded(
            child: BarChartPayments(),
          )
        ],
      ),
    );
  }
}
