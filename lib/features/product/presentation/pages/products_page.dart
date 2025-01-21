import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/core/shared_widget/app_bar_generic.dart';
import 'package:salonguru_shop/core/shared_widget/error_screen_widget.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../bloc/product_event.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_item_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBarGeneric(
        title: tr('product'),
        centerTitle: false,
        actions: const [CartIconButton()],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: BlocConsumer<ProductBloc, ProductState>(
          listenWhen: (previous, current) =>
              previous.validateItemFlag != current.validateItemFlag,
          listener: (context, state) {
            if (state.addToCartStatus == StateStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.addToCartStatus == StateStatus.loaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr('add_item')),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          buildWhen: (previous, next) =>
              previous.getProductStatus != next.getProductStatus,
          builder: (context, state) {
            if (state.getProductStatus == StateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.getProductStatus == StateStatus.loaded) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: Dimens.large),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(product: state.products[index]);
                },
              );
            } else if (state.getProductStatus == StateStatus.failed) {
              return ErrorScreenWidget(
                message: state.errorMessage,
                onPressed: () {
                  sl<ProductBloc>().add(const GetProductsEvent());
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    sl<ProductBloc>().add(const GetProductsEvent());
  }
}
