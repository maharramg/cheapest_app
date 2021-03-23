import 'dart:convert';

import 'package:cheapest_app/infrastructure/models/restaurant_model.dart';
import 'package:cheapest_app/utilities/constants/api_keys.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';
import 'package:http/http.dart' as http;

class RestaurantsProvider {
  static Future<List<RestaurantModel>> fetchAllRestaurants() async {
    final api = ApiKeys.restaurants;
    final headers = ApiKeys.headers;
    Printer.debug(api: api);
    final response = await http.get(api, headers: headers);
    Printer.debug(response: response.body);
    if (response.statusCode == 200) {
      return List<RestaurantModel>.from(json.decode(response.body).map((x) => RestaurantModel.fromJson(x)));
    } else {
      throw Exception("Error occured with statusCode: ${response.statusCode}");
    }
  }
}
