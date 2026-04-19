import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../widgets/product_card.dart';
import '../../models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  final FirestoreService _service = FirestoreService();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _service.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () {
                  // later: go to details page
                },
              );
            },
          );
        },
      ),
    );
  }
}