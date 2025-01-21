import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/features/product/domain/entities/cart_entity.dart';
import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';
import '../respositories/product_repository.dart';

class GetCart extends UseCase<List<CartEntity>, Object?> {
  GetCart({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<CartEntity>>> call(Object? params) async {
    final result = await repository.getCart();
    return result.fold(
      (l) => Left(l),
      (r) => Right(
        r
            .map(
              (e) => CartEntity(
                productId: e.product.id,
                price: e.totalPrice,
                quantity: e.quantity,
                product: ProductEntity(
                  id: e.product.id,
                  name: e.product.name,
                  quantity: e.product.quantity,
                  description: e.product.description,
                  image: e.product.image,
                  price: e.product.price,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
