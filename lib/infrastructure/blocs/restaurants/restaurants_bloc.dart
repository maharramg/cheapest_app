import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/restaurants_provider.dart';
import 'package:cheapest_app/infrastructure/models/restaurant_model.dart';
import 'package:equatable/equatable.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc() : super(RestaurantsInitial());

  @override
  Stream<RestaurantsState> mapEventToState(RestaurantsEvent event) async* {
    if (event is FetchRestaurants) {
      yield* _mapRestaurantsToState(event);
    }
  }

  Stream<RestaurantsState> _mapRestaurantsToState(FetchRestaurants event) async* {
    final List<RestaurantModel> restaurants = [];
    try {
      yield RestaurantsLoading();
      final result = await RestaurantsProvider.fetchAllRestaurants();
      restaurants.addAll(result);
      print(restaurants.length);
      yield RestaurantsLoaded(restaurants: restaurants);
    } catch (e) {
      yield RestaurantsDisplayMessage(message: "$e");
    }
  }
}
