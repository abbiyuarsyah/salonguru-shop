import 'package:hive/hive.dart';
part 'product_local_model.g.dart';

@HiveType(typeId: 2)
class ProductLocalModel {
  const ProductLocalModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    required this.price,
  });

  static const String boxName = 'ProductLocalModel';

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final double price;

  factory ProductLocalModel.empty() {
    return const ProductLocalModel(
      id: 0,
      name: '',
      quantity: 0,
      description: '',
      image: '',
      price: 0,
    );
  }
}
