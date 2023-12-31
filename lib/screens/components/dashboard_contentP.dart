import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';
import 'package:responsive_admin_dashboard/constants/responsiveP.dart';
import 'package:responsive_admin_dashboard/screens/components/analytic_cardsP.dart';
import 'package:responsive_admin_dashboard/screens/components/custom_appbarP.dart';
import 'package:responsive_admin_dashboard/screens/components/usersP.dart';
import 'package:responsive_admin_dashboard/screens/components/top_referalsP.dart';
import 'package:responsive_admin_dashboard/screens/components/users_by_deviceP.dart';
import 'package:responsive_admin_dashboard/screens/components/viewersP.dart';

class DashboardContentP extends StatelessWidget {
  const DashboardContentP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbarP(),
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
                          AnalyticCardsP(),
                          SizedBox(
                            height: appPadding,
                          ),
                          UsersP(),
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
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: UsersByDeviceP(),
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
                              if(!Responsive.isMobile(context))
                                Expanded(
                                  child: TopReferalsP(),
                                  flex: 2,
                                ),
                              if(!Responsive.isMobile(context))
                                SizedBox(width: appPadding,),
                              Expanded(
                                flex: 3,
                                child: PaymentsPerYearChart(),
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
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
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
