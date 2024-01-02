import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class ReservationList extends StatefulWidget {
  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  List<dynamic> reservations = [];

  @override
  void initState() {
    super.initState();
    _fetchReservations();
  }

  Future<void> _fetchReservations() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.18:3000/api/reservations'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchReservations = json.decode(response.body);
      setState(() {
        reservations = fetchReservations;
      });
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  Future<void> _deleteReservation(
      String reservationId, int reservationIndex) async {
    final response = await http.delete(
        Uri.parse('http://192.168.1.18:3000/api/reservations/$reservationId'));

    if (response.statusCode == 200) {
      setState(() {
        reservations.removeAt(reservationIndex);
      });
    } else {
      throw Exception('Failed to delete reservation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation List'),
      ),
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          final minPrice = double.tryParse(reservation['minPrice'] ?? '');
          final maxPrice = double.tryParse(reservation['maxPrice'] ?? '');
          final checkInDate =
              _parseDateString(reservation['checkInDate'] ?? '');

          bool isNewDay = index == 0 ||
              checkInDate.day !=
                  _parseDateString(reservations[index - 1]['checkInDate'] ?? '')
                      .day;

          return Column(
            children: [
              if (isNewDay) _buildDateHeader(checkInDate),
              _buildReservationItem(
                  context, index, minPrice, maxPrice, checkInDate),
              Divider(
                height: 1,
                color: Colors.grey[300],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.cyan,
      child: Text(
        '${date.year}-${_addLeadingZero(date.month)}-${_addLeadingZero(date.day)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildReservationItem(BuildContext context, int index,
      double? minPrice, double? maxPrice, DateTime date) {
    final reservation = reservations[index];
    final location = reservation['location']
        as String; // Replace 'location' with the actual key

    return ListTile(
      title: Text('Reservation #$index'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Min Price: \$${minPrice?.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.cyan)),
          Text('Max Price: \$${maxPrice?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(color: Colors.cyan)),
          Text('Location: $location', style: TextStyle(color: Colors.cyan)),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.cyan),
            onPressed: () {
              _showDeleteConfirmationDialog(context, index);
            },
          ),
        ],
      ),
      onTap: () {
        // Handle tap
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int reservationIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Reservation'),
        content: Text('Are you sure you want to delete this reservation?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (reservationIndex >= 0 &&
                  reservationIndex < reservations.length) {
                _deleteReservation(
                    reservations[reservationIndex]['_id'] as String,
                    reservationIndex);
              }
              Navigator.pop(context); // Close the dialog after deletion
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}-${_addLeadingZero(date.month)}-${_addLeadingZero(date.day)}';
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  DateTime _parseDateString(String dateString) {
    try {
      return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(dateString);
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now(); // or handle the error in another way
    }
  }
}
