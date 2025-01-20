import 'package:hive/hive.dart';
import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';

import 'repository.dart';

class CartRepository extends Repository<CartLocalModel> {
  CartRepository._({required hiveInterface}) : _hiveInterface = hiveInterface;

  final HiveInterface _hiveInterface;
  late Box _box;
  bool _initialized = false;

  static Future<CartRepository> create({required hiveInterface}) async {
    final repo = CartRepository._(hiveInterface: hiveInterface);

    await repo.init();
    return repo;
  }

  Future<void> init() async {
    bool isInitializing = false;
    if (_initialized == false && isInitializing == false) {
      isInitializing = true;
      _hiveInterface.registerAdapter(CartLocalModelAdapter());
      _initialized = true;
    }
  }

  @override
  Future<CartLocalModel> add(CartLocalModel entity) async {
    await _box.put(entity.id, entity);
    return Future.value(entity);
  }

  @override
  Future<void> delete() async {
    await _box.clear();
    return;
  }

  @override
  Future<List<CartLocalModel>> getAll() async {
    final values = _box.values.toList().cast<CartLocalModel>();
    return values.isEmpty
        ? Future.value([CartLocalModel.empty()])
        : Future.value(values);
  }

  Future<void> open() async {
    _box = await _hiveInterface.openBox(CartLocalModel.boxName);
  }

  @override
  Future<CartLocalModel> getCart(int productId) async {
    final values = _box.values.toList().cast<CartLocalModel>();
    final entity = values.firstWhere((e) => e.productId == productId);

    return entity;
  }
}
