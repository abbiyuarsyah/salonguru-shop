class CheckoutEntity {
  const CheckoutEntity({
    required this.totalPrice,
    required this.items,
  });

  final double totalPrice;
  final List<ItemEntity> items;

  factory CheckoutEntity.empty() {
    return const CheckoutEntity(totalPrice: 0, items: []);
  }
}

class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    required this.price,
    required this.totalPrice,
  });

  final int id;
  final String name;
  final int quantity;
  final String description;
  final String image;
  final double price;
  final double totalPrice;
}
