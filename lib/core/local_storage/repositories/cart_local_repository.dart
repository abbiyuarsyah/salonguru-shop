import 'package:hive/hive.dart';
import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';

import 'repository.dart';

class CartLocalRepository extends Repository<CartLocalModel> {
  CartLocalRepository._({required hiveInterface})
      : _hiveInterface = hiveInterface;

  final HiveInterface _hiveInterface;
  late Box _box;
  bool _initialized = false;

  static Future<CartLocalRepository> create({required hiveInterface}) async {
    final repo = CartLocalRepository._(hiveInterface: hiveInterface);

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
  Future<List<CartLocalModel>> getAll() async {
    final values = _box.values.toList().cast<CartLocalModel>();
    return values.isEmpty
        ? Future.value([CartLocalModel.empty()])
        : Future.value(values);
  }

  @override
  Future<CartLocalModel> getEntity(CartLocalModel entity) async {
    return await _box.get(entity);
  }

  @override
  Future<CartLocalModel> add(CartLocalModel entity) async {
    await _box.put(entity.id, entity);
    return Future.value(entity);
  }

  @override
  Future<void> deleteAll() async {
    await _box.clear();
    return;
  }

  @override
  Future<void> deleteEntity(CartLocalModel entity) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k) == entity,
      orElse: () => null,
    );

    return await _box.delete(key);
  }

  Future<void> open() async {
    _box = await _hiveInterface.openBox(CartLocalModel.boxName);
  }
}
