import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';

import '../../../../core/utils/execptions.dart';
import '../../data/models/checkout_model.dart';
import '../../data/models/checkout_request.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsModel>> getProducts();
  Future<Either<Failure, CheckoutModel>> doCheckout(
    List<CheckoutRequest> request,
  );
  void addToCart(int productId);
  void removeFromCart(int productId);
  Future<Either<Failure, List<CartLocalModel>>> getCart();
}
