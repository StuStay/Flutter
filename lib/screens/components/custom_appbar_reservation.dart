import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';
import 'package:responsive_admin_dashboard/constants/responsive_r.dart';
import 'package:responsive_admin_dashboard/controllers/controller_r.dart';
import 'package:responsive_admin_dashboard/screens/components/profile_info_reservation.dart';
import 'package:responsive_admin_dashboard/screens/components/search_field_reservation.dart';
import 'package:provider/provider.dart';

class CustomAppbarReservation extends StatelessWidget {
  const CustomAppbarReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: context.read<Controllerr>().controlMenu,
            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        Expanded(child: SearchFieldReservation()),
        ProfileInfoReservation()
      ],
    );
  }
}
