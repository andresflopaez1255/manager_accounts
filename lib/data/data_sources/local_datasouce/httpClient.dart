import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:manager_accounts/data/data_sources/local_datasouce/http_client.dart';

class HttpClient {
  final dio = Api.dio;
  Future<Response<dynamic>?> getApiCall(
      {required String url, Map<String, dynamic>? params}) async {
    try {
      var response = await dio.get(url, queryParameters: params);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response<dynamic>?> deleteApiCall(
      {required String url, Map<String, dynamic>? params}) async {
    try {
      var response = await dio.delete(url, queryParameters: params);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<Response<dynamic>?> postApiCall(url, data) async {
    try {
      var response = await dio.post(url,
          options: Options(contentType: "application/json"),
          data: json.encode(data));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
