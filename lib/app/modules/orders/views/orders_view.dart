import 'package:choco_bliss_mobile/app/modules/orders/views/widgets/customOrder.dart';
import 'package:choco_bliss_mobile/app/modules/orders/views/widgets/oder_detail.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          final order = controller.orders[index];
          return CustomOrder(
            orderId: order.orderId,
            customerName: order.customerName,
            totalAmount: order.totalAmount,
            orderStatus: order.orderStatus,
            orderDate: order.orderDate,
            onViewDetails: () {
              Get.to(()=>OrderDetailsPage(orderId: "ORD12345",));
              // Handle view details
            },
          );
        },
      );
    }),
    );
  }
}
