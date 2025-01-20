import 'package:hive/hive.dart';

import 'product_local_model.dart';

part 'cart_local_model.g.dart';

@HiveType(typeId: 1)
class CartLocalModel {
  const CartLocalModel({
    required this.id,
    required this.product,
    required this.totalPrice,
    required this.quantity,
  });

  static const String boxName = 'CartLocalModel';

  @HiveField(0)
  final int id;

  @HiveField(1)
  final ProductLocalModel product;

  @HiveField(2)
  final double totalPrice;

  @HiveField(3)
  final int quantity;

  factory CartLocalModel.empty() {
    return CartLocalModel(
      id: 0,
      product: ProductLocalModel.empty(),
      totalPrice: 0,
      quantity: 0,
    );
  }
}
