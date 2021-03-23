import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/auth_provider.dart';
import 'package:cheapest_app/utilities/validators/custom_email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordCController = BehaviorSubject<String>();
  final BehaviorSubject<String> _usernameController = BehaviorSubject<String>();

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get passwordC => _passwordCController.value;
  String get username => _usernameController.value;

  updateEmail(value) => _emailController.add(value);
  updatePassword(value) => _passwordController.add(value);
  updatePasswordC(value) => _passwordCController.add(value);
  updateUsername(value) => _usernameController.add(value);

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    _passwordCController.close();
    _usernameController.close();
    return super.close();
  }

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationButtonClicked) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<RegistrationState> _mapRegisterToState(RegistrationButtonClicked event) async* {
    yield RegistrationLoading();
    try {
      if (areFieldsValid()) {
        if (isEmailValid()) {
          final result = await AuthProvider.register(
            email: email,
            password: password,
            password2: passwordC,
            username: username,
          );
          if (result.token != null) {
            yield RegistrationSuccess();
          } else {
            yield RegistrationDisplayMessage(message: result.errors?.first?.msg);
          }
        } else {
          yield RegistrationDisplayMessage(message: "Enter a valid email");
        }
      } else {
        yield RegistrationDisplayMessage(message: "All fields should be valid");
      }
    } catch (e) {
      yield RegistrationDisplayMessage(message: "$e");
    }
  }

  bool areFieldsValid() => (email != null && email != "" && password != null && password != "" && passwordC != null && passwordC != "" && username != null && username != "");
  bool isEmailValid() => CustomEmailValidator.isValidEmail(email: email);
}
