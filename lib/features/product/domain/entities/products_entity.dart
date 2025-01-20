class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
  });

  final int id;
  final String name;
  final int quantity;
  final String description;
  final String image;
}
