part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginDisplayMessage extends LoginState {
  final String message;

  LoginDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
