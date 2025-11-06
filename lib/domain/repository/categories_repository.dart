
import 'package:manager_accounts/data/models/categories/categories_response.dart';

abstract class CategoriesRepository {
  Future<List<Category>> getCategories();
}