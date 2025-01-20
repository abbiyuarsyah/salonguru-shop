import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';
import 'package:salonguru_shop/core/local_storage/models/product_local_model.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/utils/execptions.dart';

abstract class ProductLocalDatasource {
  Future<Either<Failure, bool>> addToCart(int productId);
  Future<void> removeFromCart(int productId);
  Future<List<CartLocalModel>> getCart();
  Future<void> addProducts(List<ProductModel> products);
  Future<void> removeCart();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  const ProductLocalDatasourceImpl({required this.localStorage});

  final LocalStorage localStorage;

  @override
  Future<Either<Failure, bool>> addToCart(int productId) async {
    await localStorage.open();

    final products = await localStorage.getProductLocalRepository.getAll()
        as List<ProductLocalModel>;
    final product = products.firstWhere((e) => e.id == productId);
    final cartList = await localStorage.getCartLocalRepository.getAll()
        as List<CartLocalModel>;

    var newData = CartLocalModel.empty();
    final cart = cartList.firstWhereOrNull((e) => e.product.id == productId);

    if (cart != null) {
      final quantity = cart.quantity + 1;
      if (quantity > product.quantity) {
        return Left(OutOfStockItemFailure());
      }

      newData = CartLocalModel(
        id: cart.id,
        product: product,
        totalPrice: cart.totalPrice + product.price,
        quantity: quantity,
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
    return const Right(true);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await localStorage.open();

    final cartList = await localStorage.getCartLocalRepository.getAll()
        as List<CartLocalModel>;
    final cart = cartList.firstWhereOrNull((e) => e.product.id == productId);

    if (cart != null) {
      if (cart.quantity == 1) {
        await localStorage.getCartLocalRepository.deleteEntity(cart);
      } else {
        final newData = CartLocalModel(
          id: cart.id,
          product: cart.product,
          totalPrice: cart.totalPrice - cart.product.price,
          quantity: cart.quantity - 1,
        );

        await localStorage.getCartLocalRepository.add(newData);
      }
    }
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
      await localStorage.getProductLocalRepository.deleteAll();

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

  @override
  Future<void> removeCart() async {
    try {
      await localStorage.open();
      await localStorage.getCartLocalRepository.deleteAll();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
