import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';
import 'package:responsive_admin_dashboard/constants/responsiveP.dart';
import 'package:responsive_admin_dashboard/controllers/controllerP.dart';
import 'package:responsive_admin_dashboard/screens/components/dashboard_contentP.dart';

import 'components/drawer_menuP.dart';
import 'package:provider/provider.dart';

class DashBoardScreenP extends StatelessWidget {
  const DashBoardScreenP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenuP(),
      key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: DrawerMenuP(),),
            Expanded(
              flex: 5,
              child: DashboardContentP(),
            )
          ],
        ),
      ),
    );
  }
}
