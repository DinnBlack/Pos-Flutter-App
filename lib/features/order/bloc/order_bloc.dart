import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:order_management_flutter_app/features/order/repository/order_data.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../model/order_model.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderCreateStarted>(_onOrderCreateStarted);
    on<OrderFetchStarted>(_onOrderFetchStarted);
  }

  Future<void> _onOrderCreateStarted(
      OrderCreateStarted event, Emitter<OrderState> emit) async {
    try {
      emit(OrderCreateInProgress());
      // await Future.delayed(Duration(seconds: 2));
      emit(OrderCreateSuccess());
    } catch (e) {
      emit(OrderCreateFailure(error: e.toString()));
    }
  }

  Future<void> _onOrderFetchStarted(
      OrderFetchStarted event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchInProgress());
      // await Future.delayed(Duration(seconds: 2));
      final orders = demoOrders
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(OrderFetchSuccess(orders: orders));
    } catch (e) {
      emit(OrderFetchFailure(error: e.toString()));
    }
  }
}
