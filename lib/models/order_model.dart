import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> data) {
    return OrderItemModel(
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 1,
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class OrderModel {
  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final List<OrderItemModel> items;
  final double total;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> data) {
    return OrderModel(
      id: id,
      customerName: data['customerName'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      customerAddress: data['customerAddress'] ?? '',
      items: (data['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      total: (data['total'] ?? 0).toDouble(),
      status: data['status'] ?? 'placed',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}