part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {}

class DeleteProduct extends ProductsEvent {
  final int id;

  const DeleteProduct(this.id);
}
