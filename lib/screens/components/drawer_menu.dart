import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tile.dart';
import 'payment_list.dart'; // Import your PaymentList widget

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/StuStay.png"),
          ),
          DrawerListTile(
              title: 'Dash Board',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {
                // Navigate to Dashboard
                // You can replace this with the appropriate route for your dashboard
              }),
          DrawerListTile(
              title: 'Payments List',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                // Navigate to PaymentList when the tile is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentList()),
                );
              }),

          DrawerListTile(
              title: 'Statistics',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                // Navigate to Statistics
                // You can replace this with the appropriate route for your statistics
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
