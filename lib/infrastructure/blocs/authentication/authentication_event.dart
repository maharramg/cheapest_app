part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LogInPersistent extends AuthenticationEvent {
  final String token;

  LogInPersistent({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedInPersistent { token: $token }';
}