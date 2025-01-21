import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salonguru_shop/core/utils/execptions.dart';
import 'package:salonguru_shop/core/utils/http_helper.dart';
import 'package:salonguru_shop/features/product/data/datasources/product_remote_datasource.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_model.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_request.dart';
import 'package:salonguru_shop/features/product/data/models/products_model.dart';

import 'product_remote_datasource_test.mocks.dart';

@GenerateMocks([HttpClientHelper])
void main() {
  late HttpClientHelper clientHelper;
  late ProductRemoteDatasourceImpl dataSource;

  setUp(() {
    clientHelper = MockHttpClientHelper();
    dataSource = ProductRemoteDatasourceImpl(httpClient: clientHelper);
  });

  test("return the model when calling products API", () async {
    const response = ProductsModel(
      200,
      [
        ProductModel(1, "Test 1", 5, "Description", "", 2.99),
        ProductModel(2, "Test 2", 2, "Description", "", 5.56)
      ],
    );

    when(
      dataSource.getProducts(),
    ).thenAnswer(
      (_) async => Future.value(const Right(response)),
    );

    final result = await dataSource.getProducts();

    result.fold(
      (l) => null,
      (r) => expect(r, response),
    );
  });

  test("return the model when calling products API", () async {
    final request = [
      const CheckoutRequest(productId: 1, quantity: 5),
      const CheckoutRequest(productId: 2, quantity: 1),
    ];

    const response = CheckoutModel(
      200,
      '',
      CheckouItemModel(
        50.52,
        [
          ItemModel(1, "Test 1", 5, "Description", "", 2.99, 30.80),
          ItemModel(2, "Test 2", 3, "Description", "", 1.99, 25.80)
        ],
      ),
    );

    when(dataSource.doCheckout(request)).thenAnswer(
      (_) async => Future.value(const Right(response)),
    );

    final result = await dataSource.doCheckout(request);

    result.fold(
      (l) => null,
      (r) => expect(r, response),
    );
  });

  test("return unexpected failure when calling products API", () async {
    when(
      dataSource.getProducts(),
    ).thenAnswer((_) async => Future.value(Left(UnexpectedFailure())));

    final result = await dataSource.getProducts();

    result.fold((l) => expect(l, UnexpectedFailure()), (r) => null);
  });

  test("return unexpected failure when calling the datasource", () async {
    when(
      dataSource.doCheckout(
        [
          const CheckoutRequest(productId: 1, quantity: 5),
          const CheckoutRequest(productId: 2, quantity: 1),
        ],
      ),
    ).thenAnswer((_) async => Future.value(Left(UnexpectedFailure())));

    final result = await dataSource.doCheckout(
      [
        const CheckoutRequest(productId: 1, quantity: 5),
        const CheckoutRequest(productId: 2, quantity: 1),
      ],
    );

    result.fold((l) => expect(l, UnexpectedFailure()), (r) => null);
  });
}
