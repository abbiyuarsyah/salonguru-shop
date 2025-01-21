import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/extensions/number_formatter.dart';
import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/shared_widget/card_container.dart';
import 'product_detail_bottom_sheet.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductDetailBottomSheet.showBottomSheet(context, product);
      },
      child: CardContainer(
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
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        product.price.toEuroFormat,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: Dimens.medium),
                      const Text(
                        "|",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: Dimens.medium),
                      Text(
                        "${tr('stock')}: ${product.quantity}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: Dimens.medium),
                ],
              ),
            ),
            const SizedBox(width: Dimens.large),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    sl<ProductBloc>()
                        .add(AddToCartEvent(productId: product.id));
                    sl<ProductBloc>().add(const GetCartEvent());
                  },
                  icon: const Icon(Icons.add_circle_outline_outlined),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
