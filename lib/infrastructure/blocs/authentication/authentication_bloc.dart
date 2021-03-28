import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/services/hive_service.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/utilities/delegates/printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  HiveService get _hiveService => locator<HiveService>();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final preference = await PreferencesService.instance;

      await _hiveService.initialise();
      final bool hasToken = preference.hasToken;
      await Future.delayed(const Duration(seconds: 3));
      if (hasToken) {
        Printer.token(token: preference.token);
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
  }
}
