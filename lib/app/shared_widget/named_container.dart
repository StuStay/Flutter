import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/constants/app_colors.dart';

class NamedContainer extends StatelessWidget {
  final String? title;
  final Widget? child;
  final double? width;

  final Color? borderColor;

  const NamedContainer(
      {Key? key,
        required this.title,
        required this.child,
        this.width,
        this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white,
                  width: 1),
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
            ),
            child: child),
        /*Align(
            heightFactor: 1,
            widthFactor: 1,
            child: Container(
              margin: const EdgeInsets.only(top: 5, left: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: secondaryColor,
              child: Text(
                title!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            )),*/
      ],
    );
  }
}
