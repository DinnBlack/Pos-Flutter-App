import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:order_management_flutter_app/features/product/repository/product_data.dart';

import '../model/product_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductFetchStarted>(_onProductFetchStarted);
  }

  // Product fetch
  Future<void> _onProductFetchStarted(
      ProductFetchStarted event, Emitter<ProductState> emit) async {
    try {
      emit(ProductFetchInProgress());
      // await Future.delayed(Duration(seconds: 2));
      final products = demoProducts;
      emit(ProductFetchSuccess(products: products));
    } on Exception catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }
}
