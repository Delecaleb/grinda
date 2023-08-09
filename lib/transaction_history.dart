import 'package:flutter/material.dart';

class TransactionHistory extends StatelessWidget {
  // Dummy transaction data for demonstration purposes.
  final List<Map<String, dynamic>> _transactionData = [
    {'date': '2023-08-07', 'amount': 50.0},
    {'date': '2023-08-06', 'amount': 25.0},
    // Add more transaction data as needed.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: _transactionData.length,
        itemBuilder: (context, index) {
          final transaction = _transactionData[index];
          final date = transaction['date'];
          final amount = transaction['amount'];

          return ListTile(
            leading: Icon(Icons.payment),
            title: Text('Transaction Date: $date'),
            subtitle: Text('Amount: \$$amount'),
            // Add more details or customization as needed.
          );
        },
      ),
    );
  }
}
