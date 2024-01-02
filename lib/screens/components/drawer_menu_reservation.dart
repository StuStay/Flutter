import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tile_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/map.dart';
import 'package:responsive_admin_dashboard/screens/components/reservation_list.dart';
import 'package:responsive_admin_dashboard/screens/dash_board_screen.dart';

class DrawerMenuReservation extends StatelessWidget {
  const DrawerMenuReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset(
              "assets/images/385538763_990613692033329_7976933523789713360_n (1).png",
            ),
          ),

          DrawerListTileReservation(
            title: 'Reservation List',
            svgSrc: 'assets/icons/BlogPost.svg',
            tap: () {
              // Navigate to Reservation List when tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservationList()),
              );
            },
          ),

          DrawerListTileReservation(
            title: 'Payments',
            svgSrc: 'assets/icons/Statistics.svg',
            tap: () {
              // Navigate to DashBoardScreen when the 'Dash Board' tile is tapped
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashBoardScreen()),
              );
            },
          ),
          DrawerListTileReservation(
            title: 'MAP',
            svgSrc: 'assets/icons/Statistics.svg',
            tap: () {
              // Navigate to MapScreen when "Statistics" is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreen(
                          reservations: [],
                        )),
              );
            },
          ),
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
