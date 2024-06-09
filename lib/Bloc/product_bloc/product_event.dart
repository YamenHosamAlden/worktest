// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class GetProductsListEvent extends ProductEvent {}

class GetProductEvent extends ProductEvent {
final  int productId;
  GetProductEvent({
    required this.productId,
  });
}
