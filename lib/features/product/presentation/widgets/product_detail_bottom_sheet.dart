import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/extensions/number_formatter.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/shared_widget/card_container.dart';
import '../../domain/entities/products_entity.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class ProductDetailBottomSheet extends StatelessWidget {
  const ProductDetailBottomSheet({super.key, required this.product});

  final ProductEntity product;

  static void showBottomSheet(BuildContext context, ProductEntity product) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.large),
        ),
      ),
      builder: (BuildContext context) {
        return ProductDetailBottomSheet(product: product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isTopRounded: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.medium),
            child: Image.network(
              product.image,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(height: Dimens.large),
          Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.medium),
          Text(
            product.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: Dimens.medium),
          Flexible(
            child: Row(
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
          ),
          const SizedBox(height: Dimens.large),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: TextButton(
              onPressed: () {
                sl<ProductBloc>().add(AddToCartEvent(productId: product.id));
                sl<ProductBloc>().add(const GetCartEvent());
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.medium),
                ),
              ),
              child: Text(
                tr('add_to_cart'),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          const SizedBox(height: Dimens.large),
        ],
      ),
    );
  }
}
