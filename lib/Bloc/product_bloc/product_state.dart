part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
class GetProductListLoadingState extends ProductState {}

class GetProductListSuccesfulState extends ProductState {}

class GetProductListErrorState extends ProductState {
  final String message;
  GetProductListErrorState({required this.message});
}

class GetProductLoadingState extends ProductState {}

class GetProductSuccesfulState extends ProductState {}

class GetProductErrorState extends ProductState {
  final String message;
  GetProductErrorState({required this.message});
}