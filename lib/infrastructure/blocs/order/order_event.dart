part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrders extends OrderEvent {}

class SendOrder extends OrderEvent {
  final double totalAmount;
  final List<OrderProductModel> food;

  SendOrder({
    this.totalAmount,
    this.food,
  });

  @override
  List<Object> get props => [totalAmount, food];
}
