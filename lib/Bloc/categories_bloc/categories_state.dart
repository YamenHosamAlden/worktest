part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}


class GetAllCategoriesLoadingState extends CategoriesState {}

class GetAllCategoriesSuccesfulState extends CategoriesState {}

class GetAllCategoriesErrorState extends CategoriesState {
  final String message;
  GetAllCategoriesErrorState({required this.message});
}


