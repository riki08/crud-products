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

class AddProduct extends ProductsEvent {
  final String name;
  final String description;
  final String price;
  final String code;
  final String state;
  final int category;
  final Function function;

  const AddProduct(this.name, this.description, this.price, this.code,
      this.state, this.category, this.function);
}
