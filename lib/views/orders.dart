import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grinda/models/models.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/widgets/widgets.dart';

import '../controllers/controllers.dart';


class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final OrderController controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              CompletedOrdersModel order = controller.orders[index];
              return ListTile(
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.green,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                ),
                title: Text(order.serviceRendered, style: topicHeader,),
                subtitle: Text(' ${order.serviceProvider} - ${order.dateCompleted}'),
                onTap: () {
                  Get.to(()=>OrderDetailsScreen(order:order));
                },
              );
            },
          )),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
   CompletedOrdersModel order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(order.serviceRendered),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaddedContainerWidget(
                child: Text("Service Offered: ${order.serviceRendered}", style:topicHeader ,),
              ),

              PaddedContainerWidget(
                child: Text("Service Provider: ${order.serviceProvider}", style: subTopic,),
              ),
              
              PaddedContainerWidget(
                child: Text("Amount Charged: ${order.amountCharged}", style: subTopic,),
              ),
              PaddedContainerWidget(
                child: Text('Date: ${order.dateCompleted}', style: subTopic,),
              ),
            ],
          )
    );
       
  }
}
