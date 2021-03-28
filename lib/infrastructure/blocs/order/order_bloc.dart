import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/order_provider.dart';
import 'package:cheapest_app/infrastructure/models/order_product_model.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is SendOrder) {
      yield* _mapOrderToState(event);
    }
  }

  Stream<OrderState> _mapOrderToState(SendOrder event) async* {
    // try {
    yield OrderLoading();
    final result = await OrderProvider.order(
      totalAmount: event.totalAmount,
      food: event.food,
    );
    yield OrderSuccess(orderStatus: result.order.status, orderId: result.order.id);
    // } catch (e) {
    //   yield OrderDisplayMessage(message: "$e");
    // }
  }
}
