import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/core/shared_widget/card_container.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/pages/checkout_page.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_widget/app_bar_generic.dart';
import '../../../../core/shared_widget/error_screen_widget.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBarGeneric(
        title: tr('cart'),
        centerTitle: false,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listenWhen: (previous, current) =>
            previous.checkoutFlag != current.checkoutFlag,
        listener: (context, state) {
          if (state.checkoutStatus == StateStatus.loaded) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutPage()),
            );
          } else if (state.checkoutStatus == StateStatus.failed) {
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
          }
        },
        builder: (context, state) {
          if (state.getCartStatus == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.getCartStatus == StateStatus.loaded) {
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(top: Dimens.large),
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(cart: state.cart[index]);
                  },
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CardContainer(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: Dimens.xxLarge),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Dispatch the DoCheckoutEvent
                              context
                                  .read<ProductBloc>()
                                  .add(const DoCheckoutEvent());
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimens.medium),
                              ),
                            ),
                            child: Text(
                              tr('checkout'),
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.getCartStatus == StateStatus.failed) {
            return ErrorScreenWidget(message: state.errorMessage);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
