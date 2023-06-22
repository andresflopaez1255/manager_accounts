import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/domain/repository/users_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../models/users/userData.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository repository;

  UsersBloc({required this.repository}) : super(UsersInitial()) {
    on<UsersListEvent>(getUsers);
    on<NewUserEvent>(_newUseer);
  }

  getUsers(UsersListEvent event, Emitter<UsersState> emit) async {
    final listResponse = await repository.getUsers();
    emit(ListUsersData(listResponse));
  }

  FutureOr<bool> _newUseer(NewUserEvent event, Emitter<UsersState> emit) async {
    var success = false;
    emit(UsersLoadingState());
    try {
      success = await repository.newUser(event.data);
      emit(UsersLoadingState());
    } catch (error) {
      success = false;
      emit(UsersLoadingState());
    }
    return success;
  }
}
