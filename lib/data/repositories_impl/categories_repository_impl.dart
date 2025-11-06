
import 'package:manager_accounts/data/data_sources/local_datasouce/httpClient.dart';
import 'package:manager_accounts/data/models/categories/categories_response.dart';
import 'package:manager_accounts/domain/repository/categories_repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
 final HttpClient httpClient;
  CategoriesRepositoryImpl({required this.httpClient});

  @override
  Future<List<Category>> getCategories() async {
    List<Category> categoriesList = [];
    final response = await httpClient.getApiCall(url: '/categories');

    if (response?.statusCode == 200) {
      final responseFormJson = Categories.fromJson(response?.data);
      categoriesList = responseFormJson.data;
    }

    return categoriesList;

  }
  

}
