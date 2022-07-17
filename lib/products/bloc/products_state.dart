part of 'products_bloc.dart';

enum ProductStatus { initial, loading, success, error }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isSuccess => this == ProductStatus.success;
  bool get isError => this == ProductStatus.error;
  bool get isLoading => this == ProductStatus.loading;
}

class ProductsState extends Equatable {
  ProductsState({
    this.status = ProductStatus.initial,
    this.errorMessage = '',
    List<ProductModel>? products,
    List<CategoryModel>? categories,
  })  : products = products ?? [],
        categories = categories ?? [];

  final List<ProductModel>? products;
  final List<CategoryModel>? categories;
  final ProductStatus status;
  final String? errorMessage;

  ProductsState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) =>
      ProductsState(
          status: status ?? this.status,
          products: products ?? products,
          categories: categories ?? categories,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [products, categories, status, errorMessage];
}
