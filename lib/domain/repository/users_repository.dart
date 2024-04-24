import 'dart:async';

import 'package:manager_accounts/data/models/users/userData.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class UsersRepository {
  Future<List<UsersResponse>> getUsers();
  Future<bool> newUser(FormGroup form);
  Future<bool> deletedUser(int id);
}
