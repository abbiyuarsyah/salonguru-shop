import 'package:equatable/equatable.dart';
import 'package:salonguru_shop/features/product/domain/entities/cart_entity.dart';
import 'package:salonguru_shop/features/product/domain/entities/checkout_entity.dart';

import '../../../../core/enums/status.dart';
import '../../domain/entities/products_entity.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.products,
    required this.cart,
    required this.checkoutData,
    required this.getProductStatus,
    required this.getCartStatus,
    required this.checkoutStatus,
    required this.addToCartStatus,
    required this.errorMessage,
    required this.validateItemFlag,
    required this.checkoutFlag,
    required this.totalItemInCart,
  });

  final List<ProductEntity> products;
  final List<CartEntity> cart;
  final CheckoutEntity checkoutData;
  final StateStatus getProductStatus;
  final StateStatus getCartStatus;
  final StateStatus checkoutStatus;
  final StateStatus addToCartStatus;
  final bool validateItemFlag;
  final bool checkoutFlag;
  final int totalItemInCart;
  final String errorMessage;

  ProductState copyWith({
    List<ProductEntity>? products,
    List<CartEntity>? cart,
    CheckoutEntity? checkoutData,
    StateStatus? getProductStatus,
    StateStatus? getCartStatus,
    StateStatus? checkoutStatus,
    StateStatus? addToCartStatus,
    bool? validateItemFlag,
    bool? checkoutFlag,
    String? errorMessage,
    int? totalItemInCart,
  }) {
    return ProductState(
      products: products ?? this.products,
      cart: cart ?? this.cart,
      checkoutData: checkoutData ?? this.checkoutData,
      getProductStatus: getProductStatus ?? this.getProductStatus,
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
      getCartStatus: getCartStatus ?? this.getCartStatus,
      validateItemFlag: validateItemFlag ?? this.validateItemFlag,
      checkoutFlag: checkoutFlag ?? this.checkoutFlag,
      addToCartStatus: addToCartStatus ?? this.addToCartStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      totalItemInCart: totalItemInCart ?? this.totalItemInCart,
    );
  }

  @override
  List<Object> get props => [
        products,
        cart,
        checkoutData,
        getProductStatus,
        checkoutStatus,
        getCartStatus,
        validateItemFlag,
        checkoutFlag,
        addToCartStatus,
        errorMessage,
        totalItemInCart,
      ];
}
