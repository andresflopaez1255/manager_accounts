// To parse this JSON data, do
//
//     final accountsDto = accountsDtoFromMap(jsonString);

import 'dart:convert';

AccountsDto accountsDtoFromMap(String str) =>
    AccountsDto.fromMap(json.decode(str));

String accountsDtoToMap(AccountsDto data) => json.encode(data.toMap());

class AccountsDto {
  AccountsDto({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  bool status;
  List<AccountResponse> data;
  factory AccountsDto.fromJson(String str) =>
      AccountsDto.fromMap(json.decode(str));

  factory AccountsDto.fromMap(Map<String, dynamic> json) => AccountsDto(
        message: json["message"],
        status: json["status"],
        data: List<AccountResponse>.from(
            json["data"].map((x) => AccountResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}



class AccountResponse {
  AccountResponse({
    required this.id,
    required this.idUser,
    required this.emailAccount,
    required this.passAccount,
    required this.nameProfile,
    required this.codeProfile,
    required this.idCategory,
    required this.expirationDate,
    required this.nameUser,
    required this.cellphoneUser,
    required this.category,
  });

  String id;
  String idUser;
  String emailAccount;
  String passAccount;
  String nameProfile;
  int codeProfile;
  String idCategory;
  String expirationDate;
  String nameUser;
  String cellphoneUser;
  String? category;

  factory AccountResponse.fromMap(Map<String, dynamic> json) => AccountResponse(
        id: json["id"],
        idUser: json["id_user"],
        emailAccount: json["email_account"],
        passAccount: json["pass_account"],
        nameProfile: json["name_profile"],
        codeProfile: json["code_profile"],
        idCategory: json["id_category"],
        expirationDate: json["expiration_date"],
        nameUser: json["name_user"],
        cellphoneUser: json["cellphone_user"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_user": idUser,
        "email_account": emailAccount,
        "pass_account": passAccount,
        "name_profile": nameProfile,
        "code_profile": codeProfile,
        "id_category": idCategory,
        "expiration_date": expirationDate,
        "name_user": nameUser,
        "cellphone_user": cellphoneUser,
        "category": category,
      };
}
