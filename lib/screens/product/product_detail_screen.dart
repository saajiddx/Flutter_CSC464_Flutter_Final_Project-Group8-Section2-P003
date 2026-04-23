import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 100,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal),
                        ),
                        child: Text(
                          product.category,
                          style: const TextStyle(
                            color: Colors.teal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Price
                  Text(
                    "৳ ${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart,
                          color: Colors.white),
                      label: const Text(
                        "Add to Cart",
                        style:
                        TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addItem(
                          product.id,
                          product.name,
                          product.price,
                          product.imageUrl,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.name} added to cart!"),
                            action: SnackBarAction(
                              label: "View Cart",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CartScreen()),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}