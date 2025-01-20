import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';

class CartEntity {
  const CartEntity({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.product,
  });

  final int productId;
  final double price;
  final int quantity;
  final ProductEntity product;
}
