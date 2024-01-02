import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/constants/responsive_r.dart';
import 'package:responsive_admin_dashboard/screens/components/analytic_cards.dart';
import 'package:responsive_admin_dashboard/screens/components/custom_appbar.dart';
import 'package:responsive_admin_dashboard/screens/components/top_referals.dart';
import 'package:responsive_admin_dashboard/screens/components/users.dart';
import 'package:responsive_admin_dashboard/screens/components/users_by_device.dart';
import 'package:responsive_admin_dashboard/screens/components/viewers.dart';


class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            CustomAppbar(),
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
                          AnalyticCards(),
                          SizedBox(
                            height: appPadding,
                          ),
                          Users(),
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
                        child: UsersByDevice(),
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
                                  child: TopReferals(),
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