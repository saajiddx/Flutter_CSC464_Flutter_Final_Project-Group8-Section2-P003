import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isPlacingOrder = false;

  void placeOrder(BuildContext context, double total) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isPlacingOrder = true;
    });

    // simulate delay (later replace with Firebase order save)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isPlacingOrder = false;
    });

    // success dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Placed 🎉"),
        content: const Text("Your order has been placed successfully!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // NAME
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter your name" : null,
              ),

              const SizedBox(height: 12),

              // PHONE
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter phone number" : null,
              ),

              const SizedBox(height: 12),

              // ADDRESS
              TextFormField(
                controller: addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter address" : null,
              ),

              const SizedBox(height: 20),

              // TOTAL BOX
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Total Amount: ৳ ${cart.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              // PLACE ORDER BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: isPlacingOrder
                      ? null
                      : () => placeOrder(context, cart.totalAmount),
                  child: isPlacingOrder
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}