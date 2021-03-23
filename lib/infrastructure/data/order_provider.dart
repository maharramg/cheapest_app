import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/models/order_model.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/utilities/constants/api_keys.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';

class OrderProvider {
  static PreferencesService get prefs => locator<PreferencesService>();

  static Future<OrderModel> order({double totalAmount, String foodType, String restaurantId, int count, double amount}) async {
    final api = ApiKeys.order;
    final headers = {
      "Content-Type": "application/json",
      "X-Auth-Token": "${prefs.token}",
    };
    final bodyRaw = {
      "total_amount": totalAmount,
      "_food": [
        {
          "foodType": "$foodType",
          "restaurantId": "$restaurantId",
          "count": count,
          "amount": amount,
        }
      ]
    };
    print(headers);
    final body = json.encode(bodyRaw);
    Printer.debug(api: api, body: body);
    final response = await http.post(api, body: body, headers: headers);
    Printer.debug(response: response.body);
    // if (response.statusCode == 200) {
    return OrderModel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception("Error occured with the status code: ${response.statusCode}");
    // }
  }
}
