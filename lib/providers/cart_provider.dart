import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  List<CartItem> get itemList => _items.values.toList();

  double get totalAmount {
    double total = 0;
    _items.forEach((key, item) {
      total += item.totalPrice;
    });
    return total;
  }

  void addItem(String productId, String name, double price, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity += 1;
    } else {
      _items[productId] = CartItem(
        productId: productId,
        name: name,
        price: price,
        imageUrl: imageUrl,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQty(String productId) {
    _items[productId]!.quantity += 1;
    notifyListeners();
  }

  void decreaseQty(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}