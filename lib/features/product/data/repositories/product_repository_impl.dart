import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/core/local_storage/models/cart_local_model.dart';
import 'package:salonguru_shop/core/utils/execptions.dart';
import 'package:salonguru_shop/features/product/data/datasources/product_local_datasource.dart';
import 'package:salonguru_shop/features/product/data/datasources/product_remote_datasource.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_model.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_request.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';

import '../../../../core/utils/network_info.dart';
import '../../domain/respositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required this.networkInfo,
    required this.datasource,
    required this.localDatasoure,
  });

  final NetworkInfo networkInfo;
  final ProductRemoteDatasource datasource;
  final ProductLocalDatasource localDatasoure;

  @override
  Future<Either<Failure, CheckoutModel>> doCheckout(
    List<CheckoutRequest> request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.doCheckout(request);

        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (_) {
        return Left(UnexpectedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProductsModel>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.getProducts();

        return result.fold((l) {
          return Left(l);
        }, (r) {
          localDatasoure.addProducts(r.products ?? []);
          return Right(r);
        });
      } catch (_) {
        return Left(UnexpectedFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  void addToCart(int productId) {
    try {
      localDatasoure.addToCart(productId);
    } catch (_) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Either<Failure, List<CartLocalModel>>> getCart() async {
    try {
      final result = await localDatasoure.getCart();
      return Right(result);
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
