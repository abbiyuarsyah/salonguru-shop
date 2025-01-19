import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import 'product_item_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: Dimens.large),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const ProductItemWidget();
      },
    );
  }
}
