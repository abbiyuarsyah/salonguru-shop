import 'package:hive/hive.dart';

part 'cart_local_model.g.dart';

@HiveType(typeId: 1)
class CartLocalModel {
  const CartLocalModel({
    required this.id,
    required this.productId,
    required this.totalPrice,
    required this.quantity,
  });

  static const String boxName = 'CartLocalModel';

  @HiveField(0)
  final int id;

  @HiveField(1)
  final int productId;

  @HiveField(2)
  final double totalPrice;

  @HiveField(3)
  final int quantity;

  factory CartLocalModel.empty() {
    return const CartLocalModel(
      id: 0,
      productId: 0,
      totalPrice: 0,
      quantity: 0,
    );
  }
}
