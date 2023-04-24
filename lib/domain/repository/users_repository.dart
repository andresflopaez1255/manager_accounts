import 'dart:async';

import 'package:manager_accounts/data/models/users/userData.dart';

abstract class UsersRepository {
  FutureOr<List<UsersResponse>> getUsers();
}