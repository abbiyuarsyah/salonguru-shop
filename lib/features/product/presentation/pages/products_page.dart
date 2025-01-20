import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';
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
        actions: const [CartIconButton()],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, next) =>
            previous.getProductStatus != next.getProductStatus,
        builder: (context, state) {
          if (state.getProductStatus == GetProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.getProductStatus == GetProductStatus.loaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: Dimens.large),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(product: state.products[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
