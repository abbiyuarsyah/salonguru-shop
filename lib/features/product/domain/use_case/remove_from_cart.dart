import 'package:dartz/dartz.dart';

import '../../../../core/utils/execptions.dart';
import '../../../../core/utils/use_case.dart';
import '../respositories/product_repository.dart';

class RemoveFromCart extends UseCase<void, RemoveFromCartParams> {
  RemoveFromCart({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(RemoveFromCartParams params) async {
    try {
      return Right(await repository.removeFromCart(params.productId));
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}

class RemoveFromCartParams {
  const RemoveFromCartParams({required this.productId});

  final int productId;
}
