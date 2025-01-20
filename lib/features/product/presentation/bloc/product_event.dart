abstract class ProductEvent {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();
}

class GetCartEvent extends ProductEvent {
  const GetCartEvent();
}

class DoCheckoutEvent extends ProductEvent {
  const DoCheckoutEvent();
}

class AddToCartEvent extends ProductEvent {
  const AddToCartEvent({required this.productId});

  final int productId;
}

class CartBadgeEvent extends ProductEvent {
  const CartBadgeEvent();
}
