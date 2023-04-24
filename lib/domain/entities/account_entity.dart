import '/domain/entities/entities.dart';

class GetAccountsResponse {
  GetAccountsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  bool status;
  List<DataResponse> data;
}
