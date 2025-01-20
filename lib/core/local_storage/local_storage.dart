import 'package:salonguru_shop/core/local_storage/repositories/product_local_repository.dart';

import 'repositories/cart_local_repository.dart';
import 'repositories/repository.dart';

abstract class LocalStorage {
  Repository get getCartLocalRepository;
  Repository get getProductLocalRepository;

  open();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({
    required this.cartLocalRepository,
    required this.productLocalRepository,
  });

  final CartLocalRepository cartLocalRepository;
  final ProductLocalRepository productLocalRepository;

  @override
  open() async {
    await productLocalRepository.open();
    await cartLocalRepository.open();
  }

  @override
  CartLocalRepository get getCartLocalRepository => cartLocalRepository;

  @override
  ProductLocalRepository get getProductLocalRepository =>
      productLocalRepository;
}
