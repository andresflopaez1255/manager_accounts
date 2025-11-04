part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class UsersListEvent extends UsersEvent {}

class NewUserEvent extends UsersEvent {
  final FormGroup data;

  NewUserEvent({required this.data});
}

class DeleteUsersEvent extends UsersEvent {
  final String id;
  DeleteUsersEvent(this.id);
}


class SetContactUser extends UsersEvent {
  final Usercontact contact;
  SetContactUser(this.contact);
}
