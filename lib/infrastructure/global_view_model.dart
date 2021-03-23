import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalViewModel extends ChangeNotifier {
  String token;

  GlobalViewModel({bool isLoggedIn}) {
    this.isLoggedIn = isLoggedIn;
  }

  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<ScaffoldState> get scaffoldKey => this._scaffoldKey;
  set scaffoldKey(GlobalKey<ScaffoldState> value) {
    this._scaffoldKey = value;
  }

  GlobalKey<ScaffoldState> generateScaffoldKey() {
    this._scaffoldKey = GlobalKey<ScaffoldState>();
    return this._scaffoldKey;
  }

  bool isLoggedIn;
  int currentTab = 0;

  void changeTab() {
    currentTab = currentTab == 1 ? 0 : 1;
    notifyListeners();
  }

  void logUserIn() async {
    isLoggedIn = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_logged_in", isLoggedIn);
    notifyListeners();
  }

  Future<void> logUserOut() async {
    isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await locator<PreferencesService>().persistToken(token: null);
    await prefs.setBool("is_logged_in", isLoggedIn);
    notifyListeners();
  }
}
