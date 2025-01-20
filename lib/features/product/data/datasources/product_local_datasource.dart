import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';

import '../../../../core/local_storage/local_storage.dart';

abstract class ProductLocalDatasource {
  void addToCart(int productId);
  Future<List<CartLocalModel>> getCart();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  const ProductLocalDatasourceImpl({required this.localStorage});

  final LocalStorage localStorage;

  @override
  void addToCart(int productId) async {
    await localStorage.open();

    final CartLocalModel result =
        await localStorage.getRepository.getCart(productId);
    final sumPrice = result.totalPrice + result.totalPrice;
    final sumQuantity = result.quantity + result.quantity;
    final newData = CartLocalModel(
      id: result.id,
      productId: productId,
      totalPrice: sumPrice,
      quantity: sumQuantity,
    );

    await localStorage.getRepository.add(newData);
  }

  @override
  Future<List<CartLocalModel>> getCart() async {
    try {
      final result =
          await localStorage.getRepository.getAll() as List<CartLocalModel>;
      return result;
    } catch (e) {
      return [];
    }
  }
}
