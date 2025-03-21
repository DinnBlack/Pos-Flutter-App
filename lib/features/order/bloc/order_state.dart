part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

// order fetch
class OrderCreateInProgress extends OrderState {}

class OrderCreateSuccess extends OrderState {}

class OrderCreateFailure extends OrderState {
  final String error;

  OrderCreateFailure({required this.error});
}

// order fetch
class OrderFetchInProgress extends OrderState {}

class OrderFetchSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderFetchSuccess({required this.orders});
}

class OrderFetchFailure extends OrderState {
  final String error;

  OrderFetchFailure({required this.error});
}
