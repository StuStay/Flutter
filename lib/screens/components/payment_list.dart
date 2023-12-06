import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_payment.dart';

class PaymentList extends StatefulWidget {
  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  List<dynamic> payments = [];

  @override
  void initState() {
    super.initState();
    _fetchPayments();
  }

  Future<void> _fetchPayments() async {
    final response = await http.get(Uri.parse('http://192.168.1.6:3000/api/payments'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedPayments = json.decode(response.body);
      setState(() {
        payments = fetchedPayments;
      });
    } else {
      throw Exception('Failed to load payments');
    }
  }

  Future<void> _deletePayment(String paymentId, int paymentIndex) async {
    final response = await http.delete(Uri.parse('http://192.168.1.6:3000/api/payments/$paymentId'));

    if (response.statusCode == 200) {
      setState(() {
        payments.removeAt(paymentIndex);
      });
    } else {
      throw Exception('Failed to delete payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments List'),
      ),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          final amount = payment['amount'];
          final date = DateTime.parse(payment['date']);
          final paymentMethod = payment['method'];

          bool isNewDay = index == 0 || date.day != DateTime.parse(payments[index - 1]['date']).day;

          return Column(
            children: [
              if (isNewDay) _buildDateHeader(date),
              _buildPaymentItem(context, index, amount, date, paymentMethod),
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

  Widget _buildPaymentItem(BuildContext context, int index, double amount, DateTime date, String paymentMethod) {
    return ListTile(
      title: Text('Payment #$index'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: \$${amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.cyan)),
          Text('Date: ${formatDate(date)}', style: TextStyle(color: Colors.cyan)),
          Text('Method: $paymentMethod', style: TextStyle(color: Colors.cyan)),
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

  void _showDeleteConfirmationDialog(BuildContext context, int paymentIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Payment'),
        content: Text('Are you sure you want to delete this payment?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (paymentIndex >= 0 && paymentIndex < payments.length) {
                _deletePayment(payments[paymentIndex]['_id'], paymentIndex);
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


