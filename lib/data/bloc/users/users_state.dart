part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class ListUsersData extends UsersState {
  final List<UsersResponse> list;
  ListUsersData(this.list);
}

class UsersLoadingState extends UsersState {}

class SucessCreateUser extends UsersState {}

class ErrorCreateUser extends UsersState {}
class UserContactState extends UsersState {
  final Usercontact contact;
  UserContactState(this.contact);
}