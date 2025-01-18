import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/features/product/data/models/checkout_request.dart';
import 'package:salonguru_shop/features/product/domain/entities/checkout_entity.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';
import '../respositories/product_repository.dart';

class DoCheckout extends UseCase<CheckoutEntity, List<CheckoutParams>> {
  DoCheckout({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, CheckoutEntity>> call(
    List<CheckoutParams> params,
  ) async {
    final request = params
        .map(
          (e) => CheckoutRequest(quantity: e.quantity, productId: e.productId),
        )
        .toList();
    final result = await repository.doCheckout(request);

    return result.fold(
      (l) => Left(l),
      (r) => Right(
        CheckoutEntity(
          totalPrice: r.checkout?.totalPrice ?? 0,
          items: (r.checkout?.items ?? [])
              .map(
                (e) => ItemEntity(
                  id: e.id ?? '',
                  name: e.name ?? '',
                  quantity: e.quantity ?? 0,
                  description: e.description ?? '',
                  image: e.image ?? '',
                  totalPrice: e.totalPrice ?? 0,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class CheckoutParams {
  const CheckoutParams({required this.quantity, required this.productId});

  final String quantity;
  final int productId;
}
