import 'package:dartz/dartz.dart';
import 'package:salonguru_shop/features/product/domain/entities/products_entity.dart';
import 'package:salonguru_shop/features/product/domain/respositories/product_repository.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';

class GetProducts extends UseCaseNoParam<List<ProductEntity>> {
  GetProducts({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    final result = await repository.getProducts();

    return result.fold(
      (l) => Left(l),
      (r) => Right(
        (r.products ?? [])
            .map(
              (e) => ProductEntity(
                id: e.id ?? '',
                name: e.name ?? '',
                quantity: e.quantity ?? 0,
                description: e.description ?? '',
                image: e.image ?? '',
              ),
            )
            .toList(),
      ),
    );
  }
}
