import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:salonguru_shop/features/product/data/datasources/product_remote_datasource.dart';
import 'package:salonguru_shop/features/product/data/repositories/product_repository_impl.dart';
import 'package:salonguru_shop/features/product/domain/respositories/product_repository.dart';
import 'package:salonguru_shop/features/product/domain/use_case/do_checkout.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_bloc.dart';

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

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      datasource: sl(),
    ),
  );

  /// User case
  sl.registerLazySingleton(() => GetProducts(repository: sl()));
  sl.registerLazySingleton(() => DoCheckout(repository: sl()));

  /// Bloc
  sl.registerLazySingleton<ProductBloc>(
    () => ProductBloc(getProducts: sl()),
  );
}
