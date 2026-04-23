import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all products
  Stream<List<ProductModel>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // Place an order
  Future<void> placeOrder(OrderModel order) async {
    await _db.collection('orders').add(order.toMap());
  }

  // Fetch all orders
  Stream<List<OrderModel>> getOrders() {
    return _db
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }
}