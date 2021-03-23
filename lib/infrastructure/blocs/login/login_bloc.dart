import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/auth_provider.dart';
import 'package:cheapest_app/infrastructure/locator.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:cheapest_app/utilities/validators/custom_email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/subjects.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  PreferencesService get _prefs => locator<PreferencesService>();

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  String get email => _emailController.value;
  String get password => _passwordController.value;

  updateEmail(value) => _emailController.add(value);
  updatePassword(value) => _passwordController.add(value);

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    return super.close();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonClicked) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<LoginState> _mapLoginToState(LoginButtonClicked event) async* {
    yield LoginLoading();
    try {
      if (areFieldsValid()) {
        if (isEmailValid()) {
          final result = await AuthProvider.login(email: email, password: password);
          print("TOKEN: ${result.token}");
          print("MESSAGE: ${result.errors?.first?.msg}");
          if (result.token != null) {
            _prefs.persistToken(token: result.token);
            _prefs.persistIsLoggedIn(true);
            yield LoginSuccess();
          } else {
            yield LoginDisplayMessage(message: result.errors?.first?.msg);
          }
        } else {
          yield LoginDisplayMessage(message: "Enter a valid email");
        }
      } else {
        yield LoginDisplayMessage(message: "All fields should be valid");
      }
    } catch (e) {
      yield LoginDisplayMessage(message: "$e");
    }
  }

  bool areFieldsValid() => (email != null && email != "" && password != null && password != "");
  bool isEmailValid() => CustomEmailValidator.isValidEmail(email: email);
}
