import 'package:cheapest_app/infrastructure/blocs/restaurants/restaurants_bloc.dart';
import 'package:cheapest_app/infrastructure/models/restaurant_model.dart';
import 'package:cheapest_app/presentation/pages/restaurant_info_screen.dart';
import 'package:cheapest_app/presentation/widgets/items/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final _bloc = RestaurantsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchRestaurants());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc..add(FetchRestaurants()),
        child: BlocListener<RestaurantsBloc, RestaurantsState>(
          listener: (context, state) {
            if (state is RestaurantsDisplayMessage) {
              print(state.message);
            }
          },
          child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (context, state) {
              if (state is RestaurantsLoaded) {
                return _buildBody(restaurants: state.restaurants);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody({List<RestaurantModel> restaurants}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          GridView.count(
            padding: const EdgeInsets.all(10.0),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.66,
            children: restaurants.map((restaurant) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.0,
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: RestaurantItem(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RestaurantInfoScreen(restaurant: restaurant)),
                  ),
                  restaurant: restaurant,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
