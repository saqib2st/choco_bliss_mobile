import 'package:choco_bliss_mobile/app/data/Models/order.dart';
import 'package:choco_bliss_mobile/app/data/Models/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {

  var orders = <Order>[ Order(
    orderId: 'ORD12345',
    customerName: 'John Doe',
    contactNumber: '+1 555 1234',
    deliveryAddress: '123 Main Street, Cityville, Country',
    totalAmount: 120.00,
    orderStatus: 'Pending',
    orderDate: DateTime.now(),
    items: [
      OrderItem(name: 'Product A', price: 40.00, quantity: 2),
      OrderItem(name: 'Product B', price: 20.00, quantity: 2),
    ],
  ),
    Order(
      orderId: 'ORD12346',
      customerName: 'Jane Smith',
      contactNumber: '+1 555 5678',
      deliveryAddress: '456 Elm Street, Townsville, Country',
      totalAmount: 89.50,
      orderStatus: 'Completed',
      orderDate: DateTime.now().subtract(Duration(days: 2)),
      items: [
        OrderItem(name: 'Product C', price: 29.50, quantity: 1),
        OrderItem(name: 'Product D', price: 30.00, quantity: 2),
      ],
    ),].obs;

  // Method to update the status of a specific order
  void updateOrderStatus(String orderId, String newStatus) {
    int index = orders.indexWhere((order) => order.orderId == orderId);
    if (index != -1) {
      orders[index].orderStatus = newStatus;
      orders.refresh(); // Notify GetX of changes
    }
  }


  // Helper method to change color based on status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
