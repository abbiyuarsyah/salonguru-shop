import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_widget/card_container.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final ProductEntity product;

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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.medium),
            child: Image.network(
              product.image,
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
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.description,
                  maxLines: 3,
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
                    onPressed: () {},
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  ),
                  const Text(
                    '0',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                  ),
                ],
              ),
              Text(
                "${tr('stock')}: ${product.quantity}",
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
  }
}
