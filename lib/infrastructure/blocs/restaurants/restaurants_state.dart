part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();

  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final List<RestaurantModel> restaurants;

  RestaurantsLoaded({this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantsDisplayMessage extends RestaurantsState {
  final String message;

  RestaurantsDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
