import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/pages/cart_page.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/enums/status.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                sl<ProductBloc>().add(const GetCartEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),
            if ((state.getProductStatus == StateStatus.loaded &&
                    state.getCartStatus != StateStatus.failed) &&
                state.totalItemInCart > 0)
              Positioned(
                right: Dimens.medium,
                top: Dimens.medium,
                child: Container(
                  padding: const EdgeInsets.all(Dimens.extraSmall),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      Dimens.medium + Dimens.extraSmall,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: Dimens.large + Dimens.extraSmall,
                    minHeight: Dimens.large + Dimens.extraSmall,
                  ),
                  child: Text(
                    '${state.totalItemInCart}',
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
      },
    );
  }
}
