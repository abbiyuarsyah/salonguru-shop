import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/core/extensions/error_extension.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_model.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_request.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';

import '../../../../core/enums/http_method.dart';
import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/http_helper.dart';

abstract class ProductRemoteDatasource {
  Future<Either<Failure, ProductsModel>> getProducts();
  Future<Either<Failure, CheckoutModel>> doCheckout(
    List<CheckoutRequest> request,
  );
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  const ProductRemoteDatasourceImpl({required this.httpClient});

  final HttpClientHelper httpClient;

  @override
  Future<Either<Failure, ProductsModel>> getProducts() async {
    try {
      final result = await httpClient.request(
        endpoint: 'prod/products',
        method: HttpMethod.get,
      );

      if (result.statusCode == 200) {
        final response = ProductsModel.fromJson(json.decode(result.body));

        /// Verify the API’s status code rather than relying on the HTTP response code.
        if (response.statusCode == 200) {
          return Right(response);
        }
        return Left(UnexpectedFailure());
      } else {
        /// Map the HTTP Error to Failure Objects
        /// It's needed to return the error messages
        return Left(result.statusCode.httpErrorToFailure);
      }
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, CheckoutModel>> doCheckout(
    List<CheckoutRequest> request,
  ) async {
    try {
      final checkoutRequest =
          request.map((product) => product.toJson()).toList();

      final result = await httpClient.request(
        endpoint: 'prod/checkout',
        method: HttpMethod.post,
        body: json.encode(checkoutRequest),
      );

      /// Verify the API’s status code rather than relying on the HTTP response code.
      if (result.statusCode == 200) {
        final response = CheckoutModel.fromJson(json.decode(result.body));

        if (response.statusCode == 200) {
          return Right(response);
        }
        return Left(APIFailure(response.message));
      } else {
        /// Map the HTTP Error to Failure Objects
        /// It's needed to return the error messages
        return Left(result.statusCode.httpErrorToFailure);
      }
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
