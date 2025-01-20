import 'package:equatable/equatable.dart';
import 'package:salonguru_shop/features/product/domain/entities/cart_entity.dart';

import '../../../../core/enums/status.dart';
import '../../domain/entities/products_entity.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.products,
    required this.cart,
    required this.getProductStatus,
    required this.getCartStatus,
    required this.errorMessage,
    required this.totalItemInCart,
  });

  final List<ProductEntity> products;
  final List<CartEntity> cart;
  final GetProductStatus getProductStatus;
  final GetCartStatus getCartStatus;
  final int totalItemInCart;
  final String errorMessage;

  ProductState copyWith({
    List<ProductEntity>? products,
    List<CartEntity>? cart,
    GetProductStatus? getProductStatus,
    GetCartStatus? getCartStatus,
    String? errorMessage,
    int? totalItemInCart,
  }) {
    return ProductState(
      products: products ?? this.products,
      cart: cart ?? this.cart,
      getProductStatus: getProductStatus ?? this.getProductStatus,
      getCartStatus: getCartStatus ?? this.getCartStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      totalItemInCart: totalItemInCart ?? this.totalItemInCart,
    );
  }

  @override
  List<Object> get props => [
        products,
        cart,
        getProductStatus,
        getCartStatus,
        errorMessage,
        totalItemInCart,
      ];
}
