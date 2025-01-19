import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/dimens.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_item_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          tr('product'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: const [
          CartIconButton(itemCount: 3), // Add your cart icon button here
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: Dimens.large),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const ProductItemWidget();
        },
      ),
    );
  }
}
