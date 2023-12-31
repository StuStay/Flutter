import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/constants/responsive_r.dart';
import 'package:responsive_admin_dashboard/controllers/controller_r.dart';
import 'package:responsive_admin_dashboard/screens/components/dashboard_content_reservation.dart';

import 'components/drawer_menu_reservation.dart';
import 'package:provider/provider.dart';

class DashBoardReservation extends StatelessWidget {
  const DashBoardReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenuReservation(),
      key: context.read<Controllerr>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: DrawerMenuReservation(),),
            Expanded(
              flex: 5,
              child: DashboardContentReservation(),
            )
          ],
        ),
      ),
    );
  }
}
