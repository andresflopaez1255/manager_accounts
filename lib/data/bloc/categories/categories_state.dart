
 import 'package:manager_accounts/data/models/categories/categories_response.dart';

class CategoriesState {}

 class CategoriesInitial extends CategoriesState {}

 class CategoriesDataState extends CategoriesState {
   final List<Category> categories;

   CategoriesDataState(this.categories);
 }
