import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemList.length,
              itemBuilder: (ctx, i) {
                final item = cart.itemList[i];

                return ListTile(
                  leading: Image.network(item.imageUrl, width: 50),
                  title: Text(item.name),
                  subtitle: Text("৳ ${item.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => cart.decreaseQty(item.productId),
                        icon: const Icon(Icons.remove),
                      ),
                      Text("${item.quantity}"),
                      IconButton(
                        onPressed: () => cart.increaseQty(item.productId),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // TOTAL SECTION
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total: ৳ ${cart.totalAmount}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    cart.clearCart();
                  },
                  child: const Text("Checkout"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}