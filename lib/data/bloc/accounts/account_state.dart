import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';

abstract class AccountState {
 
}

class DataListAccount extends AccountState {
 final  List<AccountResponse> list;
  DataListAccount(this.list);
}

class LoadingState extends AccountState {
  final bool load;
  LoadingState(this.load);
}
