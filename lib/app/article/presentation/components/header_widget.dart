import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class Header extends StatelessWidget {
  final Function() search;
  final Function(String?) instantSearch;
  final TextEditingController controller;

  Header({
    Key? key,
    required this.controller,
    required this.search,
    required this.instantSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: primaryColor,
      child: Row(
        children: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected option (Reclamations, Reservations, Payments)
              // You can navigate to a specific page or perform an action based on the selected value
              print("Selected: $value");
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Reclamations",
                child: Text("Reclamations"),
              ),
              PopupMenuItem(
                value: "Reservations",
                child: Text("Reservations"),
              ),
              PopupMenuItem(
                value: "Payments",
                child: Text("Payments"),
              ),
            ],
          ),
          const Text(
            "Logements",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SearchField(
                controller: controller,
                search: search,
                instantSearch: (String? value) {
                  instantSearch(value);
                },
              ),
            ),
          ),
          const ProfileCard(),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showLogoutMenu(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16 / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.network(
                  "https://picsum.photos/200",
                  height: 38,
                  width: 38,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 / 2),
              child: Text(
                "Yassine Ezzar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: "Logout",
          child: Text("Log Out"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == "Logout") {
   
        print("Log Out");
      }
    });
  }
}


class SearchField extends StatelessWidget {
  final Function() search;
  final Function(String?) instantSearch;
  TextEditingController controller;
  SearchField({
    Key? key,
    required this.search,
    required this.controller,
    required this.instantSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        instantSearch(value);
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(color: Colors.white),
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: search,
          child: Container(
            padding: const EdgeInsets.all(16 * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: 16 / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
