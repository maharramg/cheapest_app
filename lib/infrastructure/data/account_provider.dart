import 'dart:convert';

import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/models/account_model.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/utilities/constants/api_keys.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';

import 'package:http/http.dart' as http;

class AccountProvider {
  static PreferencesService get prefs => locator<PreferencesService>();

  static Future<AccountModel> fetchAccount() async {
    final api = ApiKeys.profile;
    final headers = {"X-Auth-Token": "${prefs.token}"};
    Printer.debug(api: api);
    final response = await http.get(api, headers: headers);
    Printer.debug(response: response.body);
    if (response.statusCode == 200) {
      return AccountModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error occured with statusCode: ${response.statusCode}");
    }
  }
}
