import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/core/shared_widget/error_screen_widget.dart';
import 'package:salonguru_shop/core/utils/execptions.dart';
import 'package:salonguru_shop/features/product/domain/entities/cart_entity.dart';
import 'package:salonguru_shop/features/product/domain/entities/checkout_entity.dart';
import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';
import 'package:salonguru_shop/features/product/domain/use_case/add_to_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/do_checkout.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';
import 'package:salonguru_shop/features/product/presentation/pages/cart_page.dart';
import 'package:salonguru_shop/features/product/presentation/pages/checkout_page.dart';
import 'package:salonguru_shop/features/product/presentation/pages/products_page.dart';
import 'package:salonguru_shop/features/product/presentation/widgets/cart_item_widget.dart';
import 'package:salonguru_shop/features/product/presentation/widgets/checkout_item_widget.dart';
import 'package:salonguru_shop/features/product/presentation/widgets/product_item_widget.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  AddToCart,
  DoCheckout,
  GetCart,
  GetProducts,
  ProductBloc,
])
void main() {
  late AddToCart addToCart;
  late DoCheckout doCheckout;
  late GetCart getCart;
  late GetProducts getProducts;
  late ProductState productState;
  late ProductBloc productBloc;

  setUp(() async {
    addToCart = MockAddToCart();
    doCheckout = MockDoCheckout();
    getCart = MockGetCart();
    getProducts = MockGetProducts();
    productBloc = MockProductBloc();
    productState = ProductState(
      products: const [],
      cart: const [],
      getProductStatus: StateStatus.init,
      getCartStatus: StateStatus.init,
      checkoutStatus: StateStatus.init,
      addToCartStatus: StateStatus.init,
      errorMessage: '',
      totalItemInCart: 0,
      checkoutData: CheckoutEntity.empty(),
      validateItemFlag: false,
      checkoutFlag: false,
    );
  });

  MaterialApp createProductsPageWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>(
        create: (_) => productBloc,
        child: const ProductsPage(),
      ),
    );
  }

  MaterialApp createCartPageWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>(
        create: (_) => productBloc,
        child: const CartPage(),
      ),
    );
  }

  MaterialApp createCheckoutPageWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>(
        create: (_) => productBloc,
        child: const CheckoutPage(),
      ),
    );
  }

  group("widget test", () {
    testWidgets('displays loading indicator when state is loading',
        (WidgetTester tester) async {
      when(productBloc.state).thenReturn(
        productState.copyWith(getProductStatus: StateStatus.loading),
      );
      when(productBloc.stream).thenAnswer(
        (_) => Stream.value(
          productState.copyWith(getProductStatus: StateStatus.loading),
        ),
      );

      await tester.pumpWidget(createProductsPageWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  testWidgets('displays error screen when state is failed',
      (WidgetTester tester) async {
    final errorMessage = tr('unexpected_error');

    when(productBloc.state).thenReturn(
      productState.copyWith(
        getProductStatus: StateStatus.failed,
        errorMessage: errorMessage,
      ),
    );
    when(productBloc.stream).thenAnswer(
      (_) => Stream.value(
        productState.copyWith(
          getProductStatus: StateStatus.failed,
          errorMessage: errorMessage,
        ),
      ),
    );

    await tester.pumpWidget(createProductsPageWidgetUnderTest());

    expect(find.text(errorMessage), findsOneWidget);
    expect(find.byType(ErrorScreenWidget), findsOneWidget);
  });

  testWidgets('displays products when state is loaded',
      (WidgetTester tester) async {
    when(productBloc.state).thenReturn(
      productState.copyWith(
        getProductStatus: StateStatus.loaded,
        products: [
          const ProductEntity(
            id: 1,
            name: "Test 1",
            quantity: 1,
            description: "Descriptiom",
            image: "https://picsum.photos/id/1/640/480",
            price: 2.99,
          )
        ],
      ),
    );
    when(productBloc.stream).thenAnswer(
      (_) => Stream.value(
        productState.copyWith(
          getProductStatus: StateStatus.loaded,
          products: [
            const ProductEntity(
              id: 1,
              name: "Test 1",
              quantity: 1,
              description: "Description",
              image: "https://picsum.photos/id/1/640/480",
              price: 2.99,
            )
          ],
        ),
      ),
    );

    await tester.pumpWidget(createProductsPageWidgetUnderTest());

    expect(find.byType(ProductItemWidget), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('displays cart when state is loaded',
      (WidgetTester tester) async {
    when(productBloc.state).thenReturn(
      productState.copyWith(
        getCartStatus: StateStatus.loaded,
        cart: [
          const CartEntity(
            productId: 1,
            quantity: 1,
            product: ProductEntity(
              id: 1,
              name: "Test 1",
              quantity: 1,
              description: "Description",
              image: "https://picsum.photos/id/1/640/480",
              price: 2.99,
            ),
            price: 2.99,
          )
        ],
      ),
    );
    when(productBloc.stream).thenAnswer(
      (_) => Stream.value(
        productState.copyWith(
          getCartStatus: StateStatus.loaded,
          cart: [
            const CartEntity(
              productId: 1,
              quantity: 1,
              product: ProductEntity(
                id: 1,
                name: "Test 1",
                quantity: 1,
                description: "Description",
                image: "https://picsum.photos/id/1/640/480",
                price: 2.99,
              ),
              price: 2.99,
            )
          ],
        ),
      ),
    );

    await tester.pumpWidget(createCartPageWidgetUnderTest());

    expect(find.byType(CartItemWidget), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('displays checkout summary when state is loaded',
      (WidgetTester tester) async {
    when(productBloc.state).thenReturn(
      productState.copyWith(
        checkoutStatus: StateStatus.loaded,
        checkoutData: const CheckoutEntity(
          totalPrice: 50.88,
          items: [
            ItemEntity(
              id: 1,
              name: "Test 1",
              quantity: 1,
              description: "Description",
              image: "https://picsum.photos/id/1/640/480",
              price: 2.99,
              totalPrice: 50.99,
            )
          ],
        ),
      ),
    );
    when(productBloc.stream).thenAnswer(
      (_) => Stream.value(
        productState.copyWith(
          checkoutStatus: StateStatus.loaded,
          checkoutData: const CheckoutEntity(
            totalPrice: 50.88,
            items: [
              ItemEntity(
                id: 1,
                name: "Test 1",
                quantity: 1,
                description: "Description",
                image: "https://picsum.photos/id/1/640/480",
                price: 2.99,
                totalPrice: 50.99,
              )
            ],
          ),
        ),
      ),
    );

    await tester.pumpWidget(createCheckoutPageWidgetUnderTest());

    expect(find.byType(CheckoutItemWidget), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  group("unit test and use case test", () {
    test(
      'getProducts should emit [loading, failed] when data fetching  fails',
      () async* {
        when(getProducts(null)).thenAnswer(
          (_) async => Left(UnexpectedFailure()),
        );

        final expected = [
          productState.copyWith(getProductStatus: StateStatus.init),
          productState.copyWith(getProductStatus: StateStatus.loading),
          productState.copyWith(getProductStatus: StateStatus.failed),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const GetProductsEvent());
      },
    );

    test(
      'getProducts should emit [Loading, succeed] when data is fetched successfully',
      () async* {
        when(getProducts(null)).thenAnswer(
          (_) async => const Right([]),
        );

        final expected = [
          productState.copyWith(getProductStatus: StateStatus.init),
          productState.copyWith(getProductStatus: StateStatus.loading),
          productState.copyWith(getProductStatus: StateStatus.loaded),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const GetProductsEvent());
      },
    );

    test(
      'doCheckout should emit [loading, failed] when data triggering fails',
      () async* {
        when(doCheckout([
          const CheckoutParams(
            quantity: 1,
            productId: 1,
          ),
        ])).thenAnswer(
          (_) async => Left(UnexpectedFailure()),
        );

        final expected = [
          productState.copyWith(checkoutStatus: StateStatus.init),
          productState.copyWith(checkoutStatus: StateStatus.loading),
          productState.copyWith(checkoutStatus: StateStatus.failed),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const DoCheckoutEvent());
      },
    );

    test(
      'doCheckout should emit [Loading, succeed] when data is triggered successfully',
      () async* {
        when(doCheckout([
          const CheckoutParams(
            quantity: 1,
            productId: 1,
          ),
        ])).thenAnswer(
          (_) async => const Right(
            CheckoutEntity(totalPrice: 50.00, items: []),
          ),
        );
        final expected = [
          productState.copyWith(getProductStatus: StateStatus.init),
          productState.copyWith(getProductStatus: StateStatus.loading),
          productState.copyWith(getProductStatus: StateStatus.loaded),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const DoCheckoutEvent());
      },
    );

    test(
      'addToCart should emit [failed] when data triggering fails',
      () async* {
        when(addToCart(
          const AddToCartParams(productId: 1),
        )).thenAnswer(
          (_) async => Left(UnexpectedFailure()),
        );

        final expected = [
          productState.copyWith(addToCartStatus: StateStatus.init),
          productState.copyWith(addToCartStatus: StateStatus.failed),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const AddToCartEvent(productId: 1));
      },
    );

    test(
      'getCart should emit [Loading, succeed] when data is fetched successfully',
      () async* {
        when(getCart(null)).thenAnswer(
          (_) async => const Right([]),
        );

        final expected = [
          productState.copyWith(getCartStatus: StateStatus.init),
          productState.copyWith(getCartStatus: StateStatus.loading),
          productState.copyWith(getCartStatus: StateStatus.loaded),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const GetCartEvent());
      },
    );

    test(
      'getCart should emit [Loading, failed] when data fetching fails',
      () async* {
        when(getCart(null)).thenAnswer(
          (_) async => const Right([]),
        );

        final expected = [
          productState.copyWith(getCartStatus: StateStatus.init),
          productState.copyWith(getCartStatus: StateStatus.loading),
          productState.copyWith(getCartStatus: StateStatus.loaded),
        ];
        expectLater(productBloc, emitsInOrder(expected));
        productBloc.add(const GetCartEvent());
      },
    );
  });
}
