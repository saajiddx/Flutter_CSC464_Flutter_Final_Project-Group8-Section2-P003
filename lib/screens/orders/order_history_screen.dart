import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/order_model.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final FirestoreService _service = FirestoreService();
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order History",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
          // Filter Bar
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: ['All', 'placed', 'delivered', 'cancelled']
                .map((status) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(status),
                selected: _selectedFilter == status,
                selectedColor: Colors.teal,
                labelStyle: TextStyle(
                  color: _selectedFilter == status
                      ? Colors.white
                      : Colors.black,
                ),
                onSelected: (_) {
                  setState(() => _selectedFilter = status);
                },
              ),
            ))
                .toList(),
          ),
        ),

        // Orders List
        Expanded(
            child: StreamBuilder<List<OrderModel>>(
                stream: _service.getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No orders found"));
                  }

                  final orders = _selectedFilter == 'All'
                      ? snapshot.data!
                      : snapshot.data!
                      .where((o) => o.status == _selectedFilter)
                      .toList();

                  if (orders.isEmpty) {
                    return Center(
                        child: Text("No '$_selectedFilter' orders found"));
                  }

                  return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  order.customerName,
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,