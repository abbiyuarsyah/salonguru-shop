abstract class ProductEvent {
  const ProductEvent();
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();
}

class DoCheckoutEvent extends ProductEvent {
  const DoCheckoutEvent();
}

class AddToCartEvent extends ProductEvent {
  const AddToCartEvent();
}
