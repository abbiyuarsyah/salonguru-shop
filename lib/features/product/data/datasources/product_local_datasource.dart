import 'dart:math';

import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';
import 'package:salonguru_shop/core/local_storage/models/product_local_model.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import '../../../../core/local_storage/local_storage.dart';

abstract class ProductLocalDatasource {
  Future<void> addToCart(int productId);
  Future<List<CartLocalModel>> getCart();
  Future<void> addProducts(List<ProductModel> products);
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  const ProductLocalDatasourceImpl({required this.localStorage});

  final LocalStorage localStorage;

  @override
  Future<void> addToCart(int productId) async {
    await localStorage.open();

    final products = await localStorage.getProductLocalRepository.getAll()
        as List<ProductLocalModel>;
    final product = products.firstWhere((e) => e.id == productId);
    final carts = await localStorage.getCartLocalRepository.getAll()
        as List<CartLocalModel>;

    var newData = CartLocalModel.empty();
    final cart = carts.firstWhereOrNull((e) => e.product.id == productId);

    if (cart != null) {
      newData = CartLocalModel(
        id: cart.id,
        product: product,
        totalPrice: cart.totalPrice + product.price,
        quantity: cart.quantity + 1,
      );
    } else {
      newData = CartLocalModel(
        id: Random().nextInt(100),
        product: product,
        totalPrice: product.price,
        quantity: 1,
      );
    }

    await localStorage.getCartLocalRepository.add(newData);
  }

  @override
  Future<List<CartLocalModel>> getCart() async {
    await localStorage.open();

    try {
      final carts = await localStorage.getCartLocalRepository.getAll()
          as List<CartLocalModel>;
      return carts;
    } catch (_) {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> addProducts(List<ProductModel> products) async {
    try {
      await localStorage.open();

      for (int i = 0; i < products.length; i++) {
        final result = await mapToLocal(products[i]);
        localStorage.getProductLocalRepository.add(result);
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  Future<ProductLocalModel> mapToLocal(ProductModel model) async {
    return ProductLocalModel(
      id: model.id ?? 0,
      name: model.name ?? '',
      quantity: model.quantity ?? 0,
      description: model.description ?? '',
      image: model.image ?? '',
      price: model.price ?? 0,
    );
  }

  ProductModel mapToRemote(ProductLocalModel model) {
    return ProductModel(
      model.id,
      model.name,
      model.quantity,
      model.description,
      model.image,
      model.price,
    );
  }
}
