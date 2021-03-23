import 'dart:convert';

import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/utilities/constants/api_keys.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  static Future<ProductModel> fetchProducts({String searchText, String price}) async {
    final api = "${ApiKeys.products_search}/filter?search=$searchText&price=$price";
    final headers = ApiKeys.headers;
    Printer.debug(api: api);
    final response = await http.get(api, headers: headers);
    Printer.debug(response: response.body);
    // if(response.statusCode == 200){
    return ProductModel.fromJson(json.decode(response.body));
    // }
  }
}
