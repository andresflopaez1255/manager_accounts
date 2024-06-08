import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/models/accounts/get_accounts_response.dart';
import 'package:manager_accounts/data/models/basic_response.dart';
import 'package:manager_accounts/domain/repository/accounts_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

class AccountsRepositoryImpl implements AccountsRepository {
  final HttpClient httpClient;
  AccountsRepositoryImpl({required this.httpClient});
  @override
  Future<List<AccountResponse>?> getAccounts() async {
    List<AccountResponse> accountList = [];
    final response = await httpClient.getApiCall(url: '/accounts');

    if (response?.statusCode == 200) {
      final responseFormJson = AccountsDto.fromJson(response.toString());
      accountList = responseFormJson.data;
    }

    return accountList;
  }

  @override
  Future<bool> newAccount(FormGroup form) async {
    final data = {
      "id_user": form.control('client_id').value,
      "email_account": form.control('email_account').value,
      "pass_account": form.control('password').value,
      "name_profile": form.control('account_profile').value,
      "code_profile": double.parse(form.control('pin_account').value),
      "id_category": 1,
      "expiration_date":
          DateFormat('MM/dd/yyyy').format(form.control('expiration_date').value)
    };
    bool success = false;
    final response = await httpClient.postApiCall('/new_account', data);

    if (response?.statusCode == 200) {
      success = true;
    }

    return success;
  }

  @override
  Future<bool> editAccount(FormGroup form, int id) async {
    final data = {
      "id": id,
      "id_user": form.control('client_id').value,
      "email_account": form.control('email_account').value,
      "pass_account": form.control('password').value,
      "name_profile": form.control('account_profile').value,
      "code_profile": double.parse(form.control('pin_account').value),
      "id_category": 1,
      "expiration_date": "04/11/2022"
    };
    bool success = false;
    final response = await httpClient.postApiCall('/update_account', data);

    if (response?.statusCode == 200) {
      success = true;
    }

    return success;
  }

  @override
  Future<BasicResponse?> deleteAccount(int idAccount) async {
    BasicResponse? responseJson;
    final response = await httpClient
        .deleteApiCall(url: '/delete_account', params: {"id": "$idAccount"});

    if (response?.statusCode == 200) {
      responseJson = BasicResponse.fromJson(response.toString());
    }
    getAccounts();
    return responseJson;
  }
}
