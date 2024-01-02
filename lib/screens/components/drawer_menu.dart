import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tile.dart';

import 'payment_list.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/385538763_990613692033329_7976933523789713360_n (1).png"),
          ),

          DrawerListTile(
              title: 'Payments List',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentList()),
                );
              }),




          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}