class DataResponse {
  DataResponse(int i, {
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

  int id;
  int idUser;
  String emailAccount;
  String passAccount;
  String nameProfile;
  int codeProfile;
  int idCategory;
  String expirationDate;
  String nameUser;
  String cellphoneUser;
  String? category;
}
