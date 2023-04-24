
import 'dart:convert';

class BasicResponse {
  final String? message;
  final bool status;
  final void  data;
  BasicResponse({required this.message, required this.status, this.data,});
  

   factory BasicResponse.fromJson(String str) => BasicResponse.fromMap(json.decode(str));


  factory BasicResponse.fromMap(Map<String, dynamic> json) => BasicResponse(
        message: json["message"],
        status: json["status"],
        data: null
      );
}