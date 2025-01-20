import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/pages/cart_page.dart';
import 'package:salonguru_shop/features/product/presentation/pages/products_page.dart';

import 'core/service_locator/service_locator.dart';
import 'features/product/presentation/pages/checkout_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          sl<ProductBloc>()..add(const GetProductsEvent()), // Provide globally
      child: MaterialApp(
        title: tr('salon_guru_shop'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/',
        routes: {
          '/': (context) => const ProductsPage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
        },
      ),
    );
  }
}
