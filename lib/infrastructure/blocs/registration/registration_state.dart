part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationDisplayMessage extends RegistrationState {
  final String message;

  RegistrationDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
