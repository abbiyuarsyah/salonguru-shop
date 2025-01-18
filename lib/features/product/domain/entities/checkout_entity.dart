class CheckoutEntity {
  const CheckoutEntity({
    required this.totalPrice,
    required this.items,
  });

  final double totalPrice;
  final List<ItemEntity> items;
}

class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    required this.totalPrice,
  });

  final String id;
  final String name;
  final int quantity;
  final String description;
  final String image;
  final double totalPrice;
}
