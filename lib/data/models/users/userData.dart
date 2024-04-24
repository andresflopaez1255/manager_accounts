// To parse this JSON data, do
//
//     final usersdto = usersdtoFromMap(jsonString);

import 'dart:convert';

class Usersdto {
  Usersdto({
    required this.message,
    required this.status,
    required this.data,
  });

  final String message;
  final bool status;
  final List<UsersResponse> data;

  factory Usersdto.fromJson(String str) => Usersdto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usersdto.fromMap(Map<String, dynamic> json) => Usersdto(
        message: json["message"],
        status: json["status"],
        data: List<UsersResponse>.from(
            json["data"].map((x) => UsersResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class UsersResponse {
  UsersResponse({
    required this.id,
    required this.nameUser,
    required this.cellphoneUser,
    this.emailUser,
  });

  final int id;
  final String nameUser;
  final String cellphoneUser;
  final String? emailUser;

  factory UsersResponse.fromJson(String str) =>
      UsersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        id: json["id"],
        nameUser: json["name_user"],
        cellphoneUser: json["cellphone_user"],
        emailUser: json["email_user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name_user": nameUser,
        "cellphone_user": cellphoneUser,
        "email_user": emailUser,
      };
}
