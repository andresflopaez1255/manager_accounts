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





class Account {
  String? id;
  String idUser;
  String emailAccount;
  String passAccount;
  String nameProfile;
  int codeProfile;
  String idCategory;
  String expirationDate;
  String? category;
  Account({
    this.id,
    required this.idUser,
    required this.emailAccount,
    required this.passAccount,
    required this.nameProfile,
    required this.codeProfile,
    required this.idCategory,
    required this.category,
    required this.expirationDate,

  });

  /// Convierte un Map a un objeto Account
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      idUser: map['id_user'] ?? '',
      emailAccount: map['email_account'] ?? '',
      passAccount: map['pass_account'] ?? '',
      nameProfile: map['name_profile'] ?? '',
      codeProfile: (map['code_profile'] is int)
          ? map['code_profile']
          : int.tryParse(map['code_profile'].toString()) ?? 0,
      idCategory: map['id_category'] ?? '',
      category: map['category'],
      expirationDate: map['expiration_date'] ?? '',
    );
  }

  /// Convierte el objeto Account a un Map (para Firestore o JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'emailAccount': emailAccount,
      'passAccount': passAccount,
      'nameProfile': nameProfile,
      'codeProfile': codeProfile,
      'idCategory': idCategory,
      'expirationDate': expirationDate,
    };
  }
}

class UsersResponse {
  String id;
  String nameUser;
  String cellphoneUser;
  String emailUser;
  List<Account> accounts;

  UsersResponse({
    required this.id,
    required this.nameUser,
    required this.cellphoneUser,
    required this.emailUser,
    required this.accounts,
  });

  /// Convierte un Map (por ejemplo, de JSON) a un objeto UsersResponse
  factory UsersResponse.fromMap(Map<String, dynamic> map) {
    return UsersResponse(
      id: map['id'] ?? '',
      nameUser: map['name_user'] ?? '',
      cellphoneUser: map['cellphone_user'] ?? '',
      emailUser: map['email_user'] ?? '',
      accounts: map['accounts'] != null
          ? List<Account>.from(
              map['accounts'].map((x) => Account.fromMap(x)),
            )
          : [],
    );
  }

  /// Convierte el objeto UsersResponse a un Map (por ejemplo, para guardarlo en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_user': nameUser,
      'cellphone_user': cellphoneUser,
      'email_user': emailUser,
      'accounts': accounts.map((x) => x.toMap()).toList(),
    };
  }
}
