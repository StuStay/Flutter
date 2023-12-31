import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';
import 'package:responsive_admin_dashboard/constants/responsiveP.dart';
import 'package:responsive_admin_dashboard/controllers/controllerP.dart';
import 'package:responsive_admin_dashboard/screens/components/profile_infoP.dart';
import 'package:responsive_admin_dashboard/screens/components/search_fieldP.dart';
import 'package:provider/provider.dart';

class CustomAppbarP extends StatelessWidget {
  const CustomAppbarP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: context.read<Controller>().controlMenu,
            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        Expanded(child: SearchFieldP()),
        ProfileInfoP()
      ],
    );
  }
}
