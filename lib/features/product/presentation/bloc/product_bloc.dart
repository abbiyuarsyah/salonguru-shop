import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/features/product/domain/entities/checkout_entity.dart';
import 'package:salonguru_shop/features/product/domain/use_case/add_to_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/do_checkout.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/domain/use_case/remove_from_cart.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.getProducts,
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.doCheckout,
  }) : super(
          ProductState(
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
          ),
        ) {
    on<GetProductsEvent>(_onGetProductsEvent);
    on<GetCartEvent>(_onGetCartEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<RemoveFromCartEvent>(_onRemoveToCartEvent);
    on<DoCheckoutEvent>(_onDoCheckoutEvent);
    on<ResetStateEvent>(_onResetStateEvent);
  }

  final GetProducts getProducts;
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final DoCheckout doCheckout;

  Future<void> _onGetProductsEvent(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getProductStatus: StateStatus.loading));

    final result = await getProducts(null);
    result.fold((l) {
      emit(state.copyWith(
        getProductStatus: StateStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      add(const GetCartEvent());
      emit(state.copyWith(getProductStatus: StateStatus.loaded, products: r));
    });
  }

  Future<void> _onGetCartEvent(
    GetCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getCartStatus: StateStatus.loading));

    final result = await getCart(null);
    result.fold((l) {
      emit(state.copyWith(
        getCartStatus: StateStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      final totalQuantity = r.fold(0, (sum, item) => sum + item.quantity);
      final isEmptyCart = r[0].product.name.trim() == '';

      if (isEmptyCart) {
        emit(state.copyWith(
          getCartStatus: StateStatus.failed,
          errorMessage: tr('empty_cart'),
        ));
        return;
      }

      emit(state.copyWith(
        getCartStatus: StateStatus.loaded,
        cart: r,
        totalItemInCart: totalQuantity,
      ));
    });
  }

  Future<void> _onAddToCartEvent(
    AddToCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await addToCart(AddToCartParams(productId: event.productId));
    result.fold((l) {
      emit(state.copyWith(
        addToCartStatus: StateStatus.failed,
        errorMessage: l.message,
        validateItemFlag: !state.validateItemFlag,
      ));
    }, (r) async {
      add(const GetCartEvent());
    });
  }

  Future<void> _onRemoveToCartEvent(
    RemoveFromCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    await removeFromCart(RemoveFromCartParams(productId: event.productId));
    add(const GetCartEvent());
  }

  Future<void> _onDoCheckoutEvent(
    DoCheckoutEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(checkoutStatus: StateStatus.loading));

    final params = state.cart
        .map(
            (e) => CheckoutParams(quantity: e.quantity, productId: e.productId))
        .toList();
    final result = await doCheckout(params);
    result.fold((l) {
      emit(state.copyWith(
        checkoutStatus: StateStatus.failed,
        errorMessage: l.message,
        checkoutFlag: !state.checkoutFlag,
      ));
    }, (r) async {
      emit(state.copyWith(
        checkoutStatus: StateStatus.loaded,
        checkoutData: r,
        checkoutFlag: !state.checkoutFlag,
      ));
    });
  }

  Future<void> _onResetStateEvent(
    ResetStateEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      checkoutStatus: StateStatus.init,
      getProductStatus: StateStatus.init,
      getCartStatus: StateStatus.init,
    ));

    add(const GetProductsEvent());
    add(const GetCartEvent());
  }
}
