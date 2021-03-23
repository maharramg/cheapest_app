import 'dart:convert';

import 'package:cheapest_app/infrastructure/models/auth_model.dart';
import 'package:cheapest_app/utilities/constants/api_keys.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static Future<AuthModel> login({email, password}) async {
    final api = ApiKeys.login;
    final headers = ApiKeys.headers;
    final bodyRaw = {
      "email": "$email",
      "password": "$password",
    };
    final body = json.encode(bodyRaw);
    Printer.debug(api: api, body: body);
    final response = await http.post(api, body: body, headers: headers);
    Printer.debug(response: response.body);
    print(response.statusCode);
    // if (response.statusCode == 200) {
    return AuthModel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception("Error occured with statusCode: ${response.statusCode}");
    // }
  }

  static Future<AuthModel> register({String email, String password, String password2, String username}) async {
    final api = ApiKeys.register;
    final headers = ApiKeys.headers;
    final bodyRaw = {
      "email": "$email",
      "password": "$password",
      "password2": "$password2",
      "username": "$username",
    };
    final body = json.encode(bodyRaw);
    Printer.debug(api: api, body: body);
    final response = await http.post(api, body: body, headers: headers);
    Printer.debug(response: response.body);
    // if (response.statusCode == 200) {
    return AuthModel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception("Error occured with statusCode: ${response.statusCode}");
    // }
  }
}
