import 'package:choco_bliss_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:choco_bliss_mobile/app/modules/orders/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomOrder extends GetView<OrdersController> {
  final String orderId;
  final String customerName;
  final double totalAmount;
  final String orderStatus;
  final DateTime orderDate;
  final VoidCallback onViewDetails;


  CustomOrder({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    required this.orderStatus,
    required this.orderDate,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
        onViewDetails
      ,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ID: $orderId',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${orderDate.day}/${orderDate.month}/${orderDate.year}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Customer Name
              Text(
                'Customer: $customerName',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // Total Amount and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Status Dropdown
                ],
              ),
              const SizedBox(height: 10),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onViewDetails,
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 40),

                  Obx(() {
                    // Observe the status of the order and rebuild the widget when it changes
                    String currentStatus = controller.orders.firstWhere((order) => order.orderId == orderId).orderStatus;

                    return DropdownButton<String>(
                      value: currentStatus,
                      items: <String>['Pending', 'Completed', 'Cancelled'].map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(
                            status,
                            style: TextStyle(
                              color: controller.getStatusColor(status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.updateOrderStatus(orderId, newValue);
                        }
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
