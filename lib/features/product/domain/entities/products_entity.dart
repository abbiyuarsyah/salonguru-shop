class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    required this.price,
  });

  final int id;
  final String name;
  final int quantity;
  final String description;
  final String image;
  final double price;
}
