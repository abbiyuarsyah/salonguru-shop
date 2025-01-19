import 'package:flutter/material.dart';
import 'package:salonguru_shop/features/product/presentation/pages/cart_page.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Handle cart button press
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Cart button pressed')),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
        if (itemCount > 0) // Show badge only if itemCount > 0
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                '$itemCount', // Display the item count
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
