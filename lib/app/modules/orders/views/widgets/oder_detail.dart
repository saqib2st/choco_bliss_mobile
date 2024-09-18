import 'package:choco_bliss_mobile/app/data/Models/order.dart';
import 'package:choco_bliss_mobile/app/modules/orders/controllers/orders_controller.dart';
import 'package:choco_bliss_mobile/app/modules/orders/views/widgets/reciept.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends GetView<OrdersController> {
  final String orderId;

  OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = controller.orders.firstWhere((o) => o.orderId == orderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              // Implement the print functionality
              printReceipt(order);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: ${order.orderId}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Customer and Contact Details
              Text(
                'Customer: ${order.customerName}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Contact: ${order.contactNumber}',
                style: TextStyle(fontSize: 16),
              ),

              // Delivery Address
              SizedBox(height: 16),
              Text(
                'Delivery Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '${order.deliveryAddress}',
                style: TextStyle(fontSize: 16),
              ),

              // Order Status
              SizedBox(height: 16),
              Text(
                'Status: ${order.orderStatus}',
                style: TextStyle(fontSize: 16, color: _getStatusColor(order.orderStatus)),
              ),

              // Order Items Section
              SizedBox(height: 20),
              Text(
                'Order Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true, // Use shrinkWrap to make ListView fit within a column
                physics: NeverScrollableScrollPhysics(),
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text(item.name),
                    subtitle: Text('${item.quantity} x ${item.price}'),
                    trailing: Text("${item.quantity * item.price}"),
                  );
                },
              ),
              Divider(),

              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${order.totalAmount}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Print Receipt Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.print),
                  label: Text('Print Receipt'),
                  onPressed: () {
                    printReceipt(order);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to change color based on status
  Color _getStatusColor(String status) {
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

  // Method to print the receipt
  void printReceipt(Order order) {
    // Logic to print the receipt can be implemented here
    // You can use packages like 'printing' or 'pdf' for generating printable PDFs
    printReceiptFunc(order);
    print('Printing receipt for order: ${order.orderId}');
  }
}
