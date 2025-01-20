import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/features/product/domain/use_case/add_to_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.getProducts,
    required this.getCart,
    required this.addToCart,
  }) : super(
          const ProductState(
            products: [],
            cart: [],
            getProductStatus: GetProductStatus.init,
            getCartStatus: GetCartStatus.init,
            errorMessage: '',
            totalItemInCart: 0,
          ),
        ) {
    on<GetProductsEvent>(_onGetProductsEvent);
    on<GetCartEvent>(_onGetCartEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<CartBadgeEvent>(_onCartBadgetEvent);
  }

  final GetProducts getProducts;
  final GetCart getCart;
  final AddToCart addToCart;

  Future<void> _onGetProductsEvent(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getProductStatus: GetProductStatus.loading));

    final result = await getProducts(null);
    result.fold((l) {
      emit(state.copyWith(
        getProductStatus: GetProductStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        getProductStatus: GetProductStatus.loaded,
        products: r,
      ));
    });
  }

  Future<void> _onGetCartEvent(
    GetCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getCartStatus: GetCartStatus.loading));

    final result = await getCart(null);
    result.fold((l) {
      emit(state.copyWith(
        getCartStatus: GetCartStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      final totalQuantity = r.fold(0, (sum, item) => sum + item.quantity);
      emit(state.copyWith(
        getCartStatus: GetCartStatus.loaded,
        cart: r,
        totalItemInCart: totalQuantity,
      ));
    });
  }

  Future<void> _onAddToCartEvent(
    AddToCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    await addToCart(AddToCartParams(productId: event.productId));
    add(const GetCartEvent());
  }

  Future<void> _onCartBadgetEvent(
    CartBadgeEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await getCart(null);
    result.fold((l) {
      emit(state.copyWith(
        getCartStatus: GetCartStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      final totalQuantity = r.fold(0, (sum, item) => sum + item.quantity);
      emit(state.copyWith(
        getCartStatus: GetCartStatus.loaded,
        cart: r,
        totalItemInCart: totalQuantity,
      ));
    });
  }
}
