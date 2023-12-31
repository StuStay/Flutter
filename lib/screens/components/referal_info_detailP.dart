import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constantsP.dart';

import '../../models/referal_info_modelP.dart';

class ReferalInfoDetailP extends StatelessWidget {
  const ReferalInfoDetailP({Key? key, required this.info}) : super(key: key);

  final TopReferalInfoModel info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appPadding),
      padding: EdgeInsets.all(appPadding / 2),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding / 1.5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: info.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),

          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  Text(
                    '${info.count ?? 0}', // Use null-aware operator
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}