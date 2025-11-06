import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/categories/categories_event.dart';
import 'package:manager_accounts/data/bloc/categories/categories_state.dart';
import 'package:manager_accounts/domain/repository/categories_repository.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;
  CategoriesBloc({required this.categoriesRepository}) : super(CategoriesInitial()) {
    on<CategoriesListEvent>(_loadCategories);
  }


 FutureOr<void> _loadCategories(
      CategoriesListEvent event, Emitter<CategoriesState> emit) async {
    try {
      final categories = await categoriesRepository.getCategories();
      emit(CategoriesDataState(categories));
    } catch (e) {
      emit(CategoriesInitial());
      debugPrint(e.toString());
    }
  }


  

}
