import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/accounts/account_state.dart';
import 'package:manager_accounts/data/bloc/accounts/bloc_event.dart';
import 'package:manager_accounts/domain/repository/accounts_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountsRepository accountRepository;

  AccountBloc({required this.accountRepository}) : super(DataListAccount([])) {
    on<DataListEvent>(_accountsList);
    on<NewAccountEvent>(_newAccount);
    on<DeleteAccountEvent>(_deleteAccount);
    on<UpdateAccountEvent>(_updateAccount);
  }

  FutureOr<void> _accountsList(
      DataListEvent event, Emitter<AccountState> emit) async {
      try {
            final listResponse = await accountRepository.getAccounts();

    final list = listResponse;
    if (list != null) {
      emit(DataListAccount(list));
    } else {
      emit(DataListAccount([]));
    }
    
      } catch (e) {
        emit(ErrorState("Error al cargar las cuentas"));
        debugPrint(e.toString());
      }
  }

  FutureOr<bool> _newAccount(
      NewAccountEvent event, Emitter<AccountState> emit) async {
    var success = false;
    emit(LoadingState(true));
    try {
      success = await accountRepository.newAccount(event.data);
      debugPrint(event.data.toString());
      emit(LoadingState(false));
    } catch (error) {
      debugPrint("error: $error");
      success = false;
      emit(LoadingState(false));
    }
    return success;
  }

  FutureOr<bool> _updateAccount(
      UpdateAccountEvent event, Emitter<AccountState> emit) async {
    var success = false;
    emit(LoadingState(true));
    try {
      success = await accountRepository.editAccount(event.data, event.id);
      debugPrint(success.toString());
      emit(LoadingState(false));
    } catch (error) {
      debugPrint("error: $error");
      success = false;
      emit(LoadingState(false));
    }
    return success;
  }

  FutureOr<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<AccountState> emit) async {
    try {
      emit(LoadingState(true));
      final response = await accountRepository.deleteAccount(event.idAccount);
      if (response?.status == true) {
        emit(LoadingState(false));
      }
    } catch (e) {
      emit(LoadingState(false));
      debugPrint(e.toString());
    }
  }
}
