part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}


class ListUsersData extends UsersState {
  final  List<UsersResponse> list;
  ListUsersData(this.list);
}