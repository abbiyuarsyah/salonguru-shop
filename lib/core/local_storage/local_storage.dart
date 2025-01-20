import 'repositories/cart_repository.dart';
import 'repositories/repository.dart';

abstract class LocalStorage {
  Repository get getRepository;
  open();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl({required this.cartRepository});

  final CartRepository cartRepository;

  @override
  open() async {
    await cartRepository.open();
  }

  @override
  CartRepository get getRepository => cartRepository;
}
