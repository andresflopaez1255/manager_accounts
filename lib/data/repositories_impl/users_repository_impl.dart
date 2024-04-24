import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'dart:async';

import 'package:manager_accounts/domain/repository/users_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UsersRespositoryImpl extends UsersRepository {
  final HttpClient httpClient;
  UsersRespositoryImpl({required this.httpClient});
  @override
  Future<List<UsersResponse>> getUsers() async {
    List<UsersResponse> usersList = [];
    final response = await httpClient.getApiCall(url: '/users');
    if (response?.statusCode == 200) {
      final responseJson = Usersdto.fromJson(response.toString());
      usersList = responseJson.data;
      return usersList;
    }

    return usersList;
  }

  @override
  Future<bool> newUser(FormGroup form) async {
    final data = {
      "name_user": form.control('name_user').value,
      "cellphone_user": form.control('phone_user').value,
      "email_user": form.control('email_user').value,
    };
    bool success = false;
    final response = await httpClient.postApiCall('/new_user', data);

    if (response?.statusCode == 200) {
      success = true;
    }

    return success;
  }

  @override
  Future<bool> deletedUser(int id) async {
    bool success = false;
    final response = await httpClient
        .deleteApiCall(url: '/delete_user', params: {"id": "$id"});

    if (response?.statusCode == 200) {
      success = true;
    }

    return success;
  }
}
