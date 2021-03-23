part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class SendOrder extends OrderEvent {
  final double totalAmount;
  final String foodType;
  final String restaurantId;
  final int count;
  final double amount;

  SendOrder({
    this.totalAmount,
    this.foodType,
    this.restaurantId,
    this.count,
    this.amount,
  });

  @override
  List<Object> get props => [totalAmount, foodType, count];
}
