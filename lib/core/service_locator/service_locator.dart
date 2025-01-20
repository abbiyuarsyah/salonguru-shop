import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path/path.dart';
import 'package:salonguru_shop/core/local_storage/repositories/cart_local_repository.dart';
import 'package:salonguru_shop/core/local_storage/repositories/product_local_repository.dart';
import 'package:salonguru_shop/features/product/data/datasources/product_remote_datasource.dart';
import 'package:salonguru_shop/features/product/data/repositories/product_repository_impl.dart';
import 'package:salonguru_shop/features/product/domain/respositories/product_repository.dart';
import 'package:salonguru_shop/features/product/domain/use_case/add_to_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/do_checkout.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_cart.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/domain/use_case/remove_from_cart.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/product/data/datasources/product_local_datasource.dart';
import '../local_storage/local_storage.dart';
import '../utils/http_helper.dart';
import '../utils/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Core
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => const HttpClientHelper());

  /// Datasource
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(httpClient: sl()),
  );
  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasourceImpl(localStorage: sl()),
  );

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      datasource: sl(),
      localDatasoure: sl(),
    ),
  );
  sl.registerSingletonAsync<ProductLocalRepository>(() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(join(directory.path, 'local_storage'));

    return await ProductLocalRepository.create(
      hiveInterface: Hive,
    );
  });

  sl.registerSingletonAsync<CartLocalRepository>(() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(join(directory.path, 'local_storage'));

    return await CartLocalRepository.create(
      hiveInterface: Hive,
    );
  });

  /// User case
  sl.registerLazySingleton(() => GetProducts(repository: sl()));
  sl.registerLazySingleton(() => DoCheckout(repository: sl()));
  sl.registerLazySingleton(() => GetCart(repository: sl()));
  sl.registerLazySingleton(() => AddToCart(repository: sl()));
  sl.registerLazySingleton(() => RemoveFromCart(repository: sl()));

  /// Bloc
  sl.registerLazySingleton<ProductBloc>(
    () => ProductBloc(
      getProducts: sl(),
      getCart: sl(),
      addToCart: sl(),
      removeFromCart: sl(),
      doCheckout: sl(),
    ),
  );

  /// Local Storage
  sl.registerSingleton<LocalStorage>(
    LocalStorageImpl(
      cartLocalRepository: await sl.getAsync(),
      productLocalRepository: await sl.getAsync(),
    ),
  );
}
