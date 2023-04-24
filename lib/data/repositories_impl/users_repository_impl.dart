import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/models/users/userData.dart';
import 'dart:async';

import 'package:manager_accounts/domain/repository/users_repository.dart';

class UsersRespositoryImpl extends UsersRepository {
  final HttpClient httpClient;
  UsersRespositoryImpl({required this.httpClient});
  @override
  FutureOr<List<UsersResponse>> getUsers() async {
     final response = await httpClient.getApiCall('/users');
    final list = Usersdto.fromJson(response.toString());
    return list.data;
  }
  
}