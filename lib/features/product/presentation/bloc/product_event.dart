abstract class ProductEvent {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();
}

class GetCartEvent extends ProductEvent {
  const GetCartEvent();
}

class AddToCartEvent extends ProductEvent {
  const AddToCartEvent({required this.productId});

  final int productId;
}

class RemoveFromCartEvent extends ProductEvent {
  const RemoveFromCartEvent({required this.productId});

  final int productId;
}

class DoCheckoutEvent extends ProductEvent {
  const DoCheckoutEvent();
}
