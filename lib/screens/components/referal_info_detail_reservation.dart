import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';

class ReferalInfoDetailReservation extends StatelessWidget {
  const ReferalInfoDetailReservation({Key? key, required this.info}) : super(key: key);

  final Map<String, dynamic> info;

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
              color: (info['color'] as Color?)?.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(
              info['svgSrc'] as String,
              color: info['color'] as Color,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info['title'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  Text(
                    '${info['count']}',
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
