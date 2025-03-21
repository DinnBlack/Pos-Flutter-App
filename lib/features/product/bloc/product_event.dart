part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

// Product Fetch
class ProductFetchStarted extends ProductEvent {}