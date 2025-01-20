import 'package:dartz/dartz.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';
import '../respositories/product_repository.dart';

class AddToCart extends UseCase<void, AddToCartParams> {
  AddToCart({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(AddToCartParams params) async {
    try {
      return Right(repository.addToCart(params.productId));
    } catch (_) {
      return Left(DeleteCacheFailure());
    }
  }
}

class AddToCartParams {
  const AddToCartParams({required this.productId});

  final int productId;
}
