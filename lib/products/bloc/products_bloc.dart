import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products/entities/category.dart';

import 'package:products/entities/product.dart';
import 'package:products/products/repository_iml/product_repository_iml.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepositoryIml _productRepositoryIml;
  List<CategoryModel>? categories;
  ProductsBloc(this._productRepositoryIml) : super(ProductsState()) {
    on<GetProducts>(_onGetProducts);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onGetProducts(
      GetProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final apiResultCategories = await _productRepositoryIml.getCategories();

      if (apiResultCategories.data != null) {
        categories = apiResultCategories.data;

        final apiResult = await _productRepositoryIml.getProducts(categories!);
        if (apiResult.data != null) {
          emit(state.copyWith(
            status: ProductStatus.success,
            products: apiResult.data,
          ));
        } else {
          emit(state.copyWith(
            status: ProductStatus.error,
            errorMessage: apiResult.message,
          ));
        }
      } else {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMessage: apiResultCategories.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final apiResult = await _productRepositoryIml.deleteProduct(event.id);
      if (apiResult.data != null) {
        add(GetProducts());
      } else {
        emit(state.copyWith(
          status: ProductStatus.error,
          errorMessage: apiResult.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
