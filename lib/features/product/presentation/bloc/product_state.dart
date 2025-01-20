import 'package:equatable/equatable.dart';

import '../../../../core/enums/status.dart';
import '../../domain/entities/products_entity.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.products,
    required this.getProductStatus,
    required this.errorMessage,
  });

  final List<ProductEntity> products;
  final GetProductStatus getProductStatus;
  final String errorMessage;

  ProductState copyWith({
    List<ProductEntity>? products,
    GetProductStatus? getProductStatus,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      getProductStatus: getProductStatus ?? this.getProductStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [products, getProductStatus, errorMessage];
}
