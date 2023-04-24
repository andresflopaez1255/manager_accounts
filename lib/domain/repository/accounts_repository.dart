
import 'dart:async';

import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/data/models/basic_response.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class AccountsRepository {
  FutureOr<List<AccountResponse>?> getAccounts();
  Future<bool> newAccount(FormGroup form);
  Future<bool> editAccount(FormGroup form,int id);
  Future<BasicResponse?> deleteAccount(int idAccount);
}