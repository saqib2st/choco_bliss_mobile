import 'package:choco_bliss_mobile/app/data/Models/orderItem.dart';

class Order {
  String orderId;
  String customerName;
  String contactNumber;
  String deliveryAddress;
  double totalAmount;
  String orderStatus;
  DateTime orderDate;
  List<OrderItem> items;

  Order({
    required this.orderId,
    required this.customerName,
    required this.contactNumber,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.orderStatus,
    required this.orderDate,
    required this.items,
  });
}
