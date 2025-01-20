import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/extensions/number_formatter.dart';
import 'package:salonguru_shop/features/product/domain/entities/cart_entity.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/shared_widget/card_container.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isBottomRounded: true,
      isTopRounded: true,
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.large,
      ).copyWith(bottom: Dimens.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.medium),
            child: Image.network(
              cart.product.image,
              fit: BoxFit.fitWidth,
              width: 60,
            ),
          ),
          const SizedBox(width: Dimens.large),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cart.price.toEuroFormat,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      sl<ProductBloc>().add(
                        RemoveFromCartEvent(productId: cart.productId),
                      );
                    },
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  ),
                  Text(
                    "${cart.quantity}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      sl<ProductBloc>().add(
                        AddToCartEvent(productId: cart.productId),
                      );
                    },
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
