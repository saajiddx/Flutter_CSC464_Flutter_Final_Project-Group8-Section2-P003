import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, i) {
                final item = cartItems[i];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image),
                    ),
                    title: Text(item.name),
                    subtitle:
                    Text("৳ ${item.price.toStringAsFixed(2)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                              Icons.remove_circle_outline),
                          onPressed: () =>
                              cart.decreaseQuantity(item.productId),
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(
                              Icons.add_circle_outline),
                          onPressed: () =>
                              cart.increaseQuantity(item.productId),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          onPressed: () =>
                              cart.removeItem(item.productId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ৳ ${cart.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CheckoutScreen()),
                    );
                  },
                  child: const Text(
                    "Checkout",
                    style:
                    TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}