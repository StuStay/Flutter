import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants_r.dart';

class SearchFieldReservation extends StatelessWidget {
  const SearchFieldReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for Statistics",
        helperStyle: TextStyle(
          color: textColor.withOpacity(0.5),fontSize: 15,
        ),
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        prefixIcon: Icon(Icons.search,color: textColor.withOpacity(0.5),)
      ),
    );
  }
}
