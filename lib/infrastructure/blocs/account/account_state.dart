part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountModel account;

  AccountLoaded({this.account});

  @override
  List<Object> get props => [account];
}

class AccountDisplayMessage extends AccountState {
  final String message;

  AccountDisplayMessage({this.message});

  @override
  List<Object> get props => [message];
}
