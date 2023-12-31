import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PaymentList extends StatefulWidget {
  @override
  _PaymentListState createState() => _PaymentListState();
}
class PaymentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> payment;

  PaymentDetailsScreen({required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: \$${payment['amount'].toStringAsFixed(2)}'),
            Text('Date: ${payment['date']}'),
            Text('Method: ${payment['method']}'),
            Text('Number of Roommates: ${payment['numberOfRoommates']}'),
            Text('Payment Type: ${payment['paymentType'].join(', ')}'),
          ],
        ),
      ),
    );
  }
}

class _PaymentListState extends State<PaymentList> {
  List<dynamic> payments = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPayments();
  }

  Future<void> _fetchPayments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://192.168.1.6:3000/api/payments'));

      if (response.statusCode == 200) {
        final List<dynamic> fetchedPayments = json.decode(response.body);
        setState(() {
          payments = fetchedPayments;
        });
      } else {
        throw Exception('Failed to load payments');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching payments: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deletePayment(String paymentId, int paymentIndex) async {
    try {
      if (paymentIndex >= 0 && paymentIndex < payments.length) {
        final response = await http.delete(Uri.parse('http://192.168.1.6:3000/api/payments/$paymentId'));

        if (response.statusCode == 200) {
          setState(() {
            payments.removeAt(paymentIndex);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment refunded successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          throw Exception('Failed to refund payment');
        }
      } else {
        throw RangeError('Index out of range');
      }
    } catch (e) {
      print('Error refunding payment: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error refunding payment'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildYearHeader(int year) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.blue,
      child: Text(
        'Year $year',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPaymentItem(BuildContext context, int index, double amount, DateTime date, String paymentMethod) {
    final payment = payments[index];

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
      trailing: IconButton(
        icon: Icon(Icons.recycling, color: Colors.cyan),
        onPressed: () async {
          bool deleteConfirmed = await _showDeleteConfirmationDialog(context);
          if (deleteConfirmed) {
            _deletePayment(payment['_id'], index);
          }
        },
        tooltip: 'Refund Payment',
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentDetailsScreen(payment: payment),
          ),
        );
      },
    );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Refund Payment'),
        content: Text('Are you sure you want to refund this payment?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Refund'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments List'),
        actions: [
          IconButton(
            onPressed: _sortPaymentsByYear,
            icon: Icon(Icons.sort),
            tooltip: 'Sort by Year',
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(errorMessage),
      )
          : payments.isEmpty
          ? Center(
        child: Text('No payments available'),
      )
          : AnimatedList(
        initialItemCount: payments.length,
        itemBuilder: (context, index, animation) {
          final payment = payments[index];
          final amount = payment['amount'];
          final date = DateTime.parse(payment['date']);
          final paymentMethod = payment['method'];

          bool isNewYear = index == 0 || date.year != DateTime.parse(payments[index - 1]['date']).year;

          return _buildAnimatedItem(
            context,
            index,
            amount,
            date,
            paymentMethod,
            isNewYear,
            animation,
          );
        },
      ),
    );
  }

  Widget _buildAnimatedItem(
      BuildContext context,
      int index,
      double amount,
      DateTime date,
      String paymentMethod,
      bool isNewYear,
      Animation<double> animation,
      ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            child: Column(
              children: [
                if (isNewYear) _buildYearHeader(date.year),
                _buildPaymentItem(context, index, amount, date, paymentMethod),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sortPaymentsByYear() {
    setState(() {
      payments.sort((a, b) => DateTime.parse(b['date']).year.compareTo(DateTime.parse(a['date']).year));
    });
  }
}
