import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: order.status == 'placed'
                      ? Colors.orange.shade100
                      : order.status == 'delivered'
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: order.status == 'placed'
                        ? Colors.orange
                        : order.status == 'delivered'
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: order.status == 'placed'
                        ? Colors.orange
                        : order.status == 'delivered'
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Customer Information",
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _infoRow(Icons.person, "Name", order.customerName),
            _infoRow(Icons.phone, "Phone", order.customerPhone),
            _infoRow(
                Icons.location_on, "Address", order.customerAddress),
            const SizedBox(height: 20),
            const Text(
              "Order Items",
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 😎,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(item.name,
                          style: const TextStyle(fontSize: 14)),
                    ),
                    Text("x${item.quantity}",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 14)),
                    const SizedBox(width: 16),
                    Text(
                      "৳ ${(item.price * item.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  "৳ ${order.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Ordered on: ${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}  ${order.createdAt.hour}:${order.createdAt.minute.toString().padLeft(2, '0')}",
                style:
                    const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.teal),
          const SizedBox(width: 😎,
          Text("$label: ",
              style: const TextStyle(color: Colors.grey)),
          Expanded(
            child: Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
