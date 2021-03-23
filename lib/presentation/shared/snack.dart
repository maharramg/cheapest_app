import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/material.dart';

class Snack {
  static display({
    @required BuildContext context,
    @required String message,
    bool positive,
  }) {
    Scaffold.of(context).hideCurrentSnackBar();
    final snackbar = SnackBar(
      backgroundColor: Colors.blueGrey.shade900,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: bodyText3.copyWith(color: Colors.white),
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
