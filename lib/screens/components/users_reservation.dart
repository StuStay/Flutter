import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';

import 'bar_chart_users_reservation.dart';

class UsersReservation extends StatelessWidget {
  const UsersReservation({Key? key}) : super(key: key);

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
            "Location Analysis",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
          Expanded(
            child: BarChartUsersReservation(),
          )
        ],
      ),
    );
  }
}
