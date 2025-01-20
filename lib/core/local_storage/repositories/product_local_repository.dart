import 'package:hive/hive.dart';
import 'package:salonguru_shop/core/local_storage/models/product_local_model.dart';

import 'repository.dart';

class ProductLocalRepository extends Repository<ProductLocalModel> {
  ProductLocalRepository._({required hiveInterface})
      : _hiveInterface = hiveInterface;

  final HiveInterface _hiveInterface;
  late Box _box;
  bool _initialized = false;

  static Future<ProductLocalRepository> create({required hiveInterface}) async {
    final repo = ProductLocalRepository._(hiveInterface: hiveInterface);

    await repo.init();
    return repo;
  }

  Future<void> init() async {
    bool isInitializing = false;
    if (_initialized == false && isInitializing == false) {
      isInitializing = true;
      _hiveInterface.registerAdapter(ProductLocalModelAdapter());
      _initialized = true;
    }
  }

  @override
  Future<List<ProductLocalModel>> getAll() async {
    final values = _box.values.toList().cast<ProductLocalModel>();
    return values.isEmpty
        ? Future.value([ProductLocalModel.empty()])
        : Future.value(values);
  }

  @override
  Future<ProductLocalModel> getEntity(ProductLocalModel entity) async {
    return await _box.get(entity);
  }

  @override
  Future<ProductLocalModel> add(ProductLocalModel entity) async {
    await _box.put(entity.id, entity);
    return Future.value(entity);
  }

  @override
  Future<void> deleteAll() async {
    await _box.clear();
    return;
  }

  @override
  Future<void> deleteEntity(ProductLocalModel entity) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k) == entity,
      orElse: () => null,
    );

    return await _box.delete(key);
  }

  Future<void> open() async {
    _box = await _hiveInterface.openBox(ProductLocalModel.boxName);
  }
}
