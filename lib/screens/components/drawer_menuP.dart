import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tileP.dart';
import 'payment_list.dart';

class DrawerMenuP extends StatelessWidget {
  const DrawerMenuP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/StuStay.png"),
          ),
          DrawerListTileP(
              title: 'Dash Board Payment',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {

              }),
          DrawerListTileP(
              title: 'Payments List',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentList()),
                );
              }),
          DrawerListTileP(
            title: 'Dash Board Reservation',
            svgSrc: 'assets/icons/Dashboard.svg',
            tap: () {

            },
          ),

          DrawerListTileP(
              title: 'Reservation List',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {


              }),
          DrawerListTileP(
              title: 'Reservation Locations',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {

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
