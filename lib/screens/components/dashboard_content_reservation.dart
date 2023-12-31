import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/constants/responsive_r.dart';
import 'package:responsive_admin_dashboard/screens/components/analytic_cards_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/custom_appbar_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/top_referals_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/users_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/reservation_by_device.dart';
import 'package:responsive_admin_dashboard/screens/components/viewers_reservation.dart';



class DashboardContentReservation extends StatelessWidget {
  const DashboardContentReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbarReservation(),
            SizedBox(
              height: appPadding,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          AnalyticCardsReservation(),
                          SizedBox(
                            height: appPadding,
                          ),
                          UsersReservation(),
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                         
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
                      ),
                    
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: appPadding,
                          ),
                          Row(
                            children: [
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  child: TopReferalsReservation(),
                                  flex: 2,
                                ),
                              if (!Responsive.isMobile(context))
                                SizedBox(
                                  width: appPadding,
                                ),
                              Expanded(
                                flex: 3,
                                child: ViewersReservation(),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          SizedBox(
                            height: appPadding,
                          ),
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                          if (Responsive.isMobile(context)) TopReferalsReservation(),
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                          if (Responsive.isMobile(context)) ReservationByDevice(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
                      ),
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: ReservationByDevice(),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
