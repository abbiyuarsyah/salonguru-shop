import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/pages/cart_page.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            sl<ProductBloc>().add(const GetCartEvent());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
        BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state.totalItemInCart < 1) {
            return const SizedBox();
          }

          return Positioned(
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
              child: Builder(builder: (context) {
                return Text(
                  '${state.totalItemInCart}', // Display the item count
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}
