import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/utilities/constants/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static PreferencesService _instance;
  static SharedPreferences _preferences;

  PreferencesService._internal();

  static Future<PreferencesService> get instance async {
    if (_instance == null) {
      _instance = PreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<bool> clear() async {
    return await _preferences.clear();
  }

  Future<void> persistToken({String token}) async {
    return await _preferences.setString(SharedKeys.token, token);
  }

  String get token => _preferences.getString(SharedKeys.token);
  bool get hasToken => _preferences.containsKey(SharedKeys.token) ?? false;

  Future<void> persistIsLoggedIn(bool value) async {
    await _preferences.setBool('is_logged_in', value);
  }

  bool get isLoggedIn => _preferences.getBool('is_logged_in') ?? false;
}
