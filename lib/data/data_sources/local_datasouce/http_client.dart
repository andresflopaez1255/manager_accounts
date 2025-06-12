import 'package:dio/dio.dart';
import 'package:manager_accounts/utils/config/constants.dart';

class Api {
 
  static BaseOptions options = BaseOptions(
  baseUrl: Constants.baseURL,
  responseType: ResponseType.json,
  connectTimeout: const Duration(milliseconds: 30000),
  receiveTimeout: const Duration(milliseconds: 30000));
  static final  dio = Dio(options);
}