import 'package:dartz/dartz.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';
import '../respositories/product_repository.dart';

class AddToCart extends UseCase<bool, AddToCartParams> {
  AddToCart({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, bool>> call(AddToCartParams params) async {
    final result = await repository.addToCart(params.productId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}

class AddToCartParams {
  const AddToCartParams({required this.productId});

  final int productId;
}
