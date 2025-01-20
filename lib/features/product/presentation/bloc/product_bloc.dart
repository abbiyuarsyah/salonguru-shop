import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salonguru_shop/core/enums/status.dart';
import 'package:salonguru_shop/features/product/domain/use_case/get_products.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_event.dart';
import 'package:salonguru_shop/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.getProducts})
      : super(
          const ProductState(
            products: [],
            getProductStatus: GetProductStatus.init,
            errorMessage: '',
          ),
        ) {
    on<GetProductsEvent>(_onGetProductsEvent);
  }

  final GetProducts getProducts;

  Future<void> _onGetProductsEvent(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(getProductStatus: GetProductStatus.loading));

    final result = await getProducts(null);
    result.fold((l) {
      emit(state.copyWith(
        getProductStatus: GetProductStatus.failed,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        getProductStatus: GetProductStatus.loaded,
        products: r,
      ));
    });
  }
}
