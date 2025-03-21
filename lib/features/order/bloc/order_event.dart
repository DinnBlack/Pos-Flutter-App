part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

// order fetch
class OrderCreateStarted extends OrderEvent {}

// order fetch
class OrderFetchStarted extends OrderEvent {}
