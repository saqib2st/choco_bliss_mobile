import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:choco_bliss_mobile/app/data/Models/order.dart';

void printReceiptFunc(Order order) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Text('Choco Bliss POS',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Order ID: ${order.orderId}', style: pw.TextStyle(fontSize: 12)),
            pw.Text('Date: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}', style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),
            pw.Text('Customer Info:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text('Name: ${order.customerName}', style: pw.TextStyle(fontSize: 12)),
            pw.Text('Phone: ${order.contactNumber}', style: pw.TextStyle(fontSize: 12)),
            pw.Text('Address: ${order.deliveryAddress}', style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 16),

            pw.Text('Order Items:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Divider(),
            ...order.items.map((item) {
              return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(child: pw.Text(item.name, style: pw.TextStyle(fontSize: 12))),
                  pw.Text('${item.quantity} x ${item.price.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('${(item.quantity * item.price).toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
                ],
              );
            }).toList(),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Subtotal:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('\$${order.totalAmount.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Delivery Fee:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('--', style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('\$${order.totalAmount.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 12)),
              ],
            ),
            pw.SizedBox(height: 16),

            pw.Text('Payment Method: Cash', style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 16),

            pw.Center(
              child: pw.Text('Thank you for shopping with us!',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)
              ),
            ),
            pw.Center(
              child: pw.Text('Visit again!', style: pw.TextStyle(fontSize: 12)),
            ),
          ],
        );
      },
    ),
  );

  // Print the document
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
