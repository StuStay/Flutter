import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ReclamationList extends StatefulWidget {
  @override
  _ReclamationListState createState() => _ReclamationListState();
}

class _ReclamationListState extends State<ReclamationList> {
  List<dynamic> reclamations = [];

  @override
  void initState() {
    super.initState();
    _fetchReclamations();
  }

  Future<void> _fetchReclamations() async {
    final response = await http.get(Uri.parse('http://172.16.0.181/api/reclamations'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedReclamations = json.decode(response.body);
      setState(() {
        reclamations = fetchedReclamations;
      });
    } else {
      throw Exception('Failed to load Reclamations');
    }
  }

  Future<void> _deleteReclamation(String reclamationId, int reclamationIndex) async {
    final response = await http.delete(Uri.parse('http://172.16.0.181/api/reclamations/$reclamationId'));

    if (response.statusCode == 200) {
      setState(() {
        reclamations.removeAt(reclamationIndex);
      });
    } else {
      throw Exception('Failed to delete reclamtions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reclamations List'),
      ),
      body: ListView.builder(
        itemCount: reclamations.length,
        itemBuilder: (context, index) {
          final reclamation = reclamations[index];
          final amount = reclamation['amount'];
          final date = DateTime.parse(reclamation['date']);
          final reclamationMethod = reclamation['method'];

          bool isNewDay = index == 0 || date.day != DateTime.parse(reclamations[index - 1]['date']).day;

          return Column(
            children: [
              if (isNewDay) _buildDateHeader(date),
              _buildReclamationItem(context, index, amount, date, reclamationMethod),
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

  Widget _buildReclamationItem(BuildContext context, int index, double amount, DateTime date, String reclamationMethod) {
    return ListTile(
      title: Text('reclamation #$index'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: \$${amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.cyan)),
          Text('Date: ${formatDate(date)}', style: TextStyle(color: Colors.cyan)),
          Text('Method: $reclamationMethod', style: TextStyle(color: Colors.cyan)),
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
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int reclamationIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete reclamation'),
        content: Text('Are you sure you want to delete this reclamations?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (reclamationIndex >= 0 && reclamationIndex < reclamations.length) {
                _deleteReclamation(reclamations[reclamationIndex]['_id'], reclamationIndex);
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
}


