part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String orderStatus;
  final String orderId;

  OrderSuccess({this.orderStatus, this.orderId});

  @override
  List<Object> get props => [orderStatus, orderId];
}

class OrderDisplayMessage extends OrderState {
  final String message;

  OrderDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
