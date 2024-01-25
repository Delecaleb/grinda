import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:grinda/controllers/payment_history_controller.dart';
import 'package:grinda/utils/styles.dart';

class TransactionHistory extends StatelessWidget {
  String userId;
  TransactionHistory({required this.userId});

  PaymentHistoryController paymentHistory = Get.put(PaymentHistoryController());
  // Dummy transaction data for demonstration purposes.
  final List<Map<String, dynamic>> _transactionData = [
    {'date': '2023-08-07', 'amount': 50.0},
    {'date': '2023-08-06', 'amount': 25.0},
    // Add more transaction data as needed.
  ];
  @override
  Widget build(BuildContext context) {
  
  paymentHistory.getPaymentHistory(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Obx(() {
          return ListView.builder(
            itemCount: paymentHistory.paymentsList.length,
            itemBuilder: (context, index) {
              final transaction = paymentHistory.paymentsList[index];
              final date = transaction['created_at'];
              final amount = transaction['amount'];
              DateTime dateTime = DateTime.parse(date);
              String dateFormat = DateFormat('MMM d, y').format(dateTime);
              return ListTile(
                leading: Image.asset('assets/card.jpg'),
                title: Text('Amount'),
                subtitle: Text('₦$amount', style:titleHeader,),
                trailing: Text('$dateFormat'),
                // Add more details or customization as needed.
              );
            },
          );
        }
      ),
    );
  }
}
