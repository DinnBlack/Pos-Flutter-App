part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

// Product Fetch
class ProductFetchInProgress extends ProductState {}

class ProductFetchSuccess extends ProductState {
  final List<ProductModel> products;

  ProductFetchSuccess({required this.products});
}

class ProductFetchFailure extends ProductState {
  final String error;

  ProductFetchFailure({required this.error});
}
