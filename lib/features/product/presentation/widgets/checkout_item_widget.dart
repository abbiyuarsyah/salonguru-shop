import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/extensions/number_formatter.dart';
import 'package:salonguru_shop/features/product/domain/entities/checkout_entity.dart';
import 'package:salonguru_shop/features/product/presentation/widgets/cart_item_widget.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_widget/card_container.dart';

class CheckoutItemWidget extends StatelessWidget {
  const CheckoutItemWidget({super.key, required this.item});

  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isBottomRounded: true,
      isTopRounded: true,
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.large,
      ).copyWith(bottom: Dimens.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.medium),
            child: Image.network(
              item.image,
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
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Dimens.large),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Quantity: ${item.quantity}",
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                item.totalPrice.toEuroFormat,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
