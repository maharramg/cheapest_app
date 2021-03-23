import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cheapest_app/infrastructure/data/account_provider.dart';
import 'package:cheapest_app/infrastructure/models/account_model.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchAccount) {
      yield* _mapAccountToState(event);
    }
  }

  Stream<AccountState> _mapAccountToState(FetchAccount event) async* {
    try {
      yield AccountLoading();
      print("salam");
      final result = await AccountProvider.fetchAccount();
      print(result.username);
      yield AccountLoaded(account: result);
    } catch (e) {
      yield AccountDisplayMessage(message: "$e");
    }
  }
}
