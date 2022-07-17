import 'package:flutter/services.dart';
import 'package:products/entities/api_response.dart';
import 'package:products/entities/category.dart';
import 'package:products/entities/product.dart';
import 'package:products/products/repository_iml/product_repository_iml.dart';
import 'package:products/utils/api_helper.dart';

class ProductRepository implements ProductRepositoryIml {
  final ApiBaseHelper _apiBaseHelper;

  ProductRepository(this._apiBaseHelper);

  @override
  Future<ApiResponse> getProducts(List<CategoryModel> categories) async {
    final response = await _apiBaseHelper.getHttp('productos');

    if (response.data != null && response.status == 200) {
      response.data =
          (response.data as List).map((i) => ProductModel.fromJson(i)).toList();

      response.data.map((ProductModel product) {
        final category = categories
            .firstWhere((element) => element.id == product.idCategoria)
            .nombre;

        product.setCategory = category;
      }).toList();

      return response;
    }
    return response;
  }

  @override
  Future<ApiResponse> getCategories() async {
    final response = await _apiBaseHelper.getHttp('categorias');

    if (response.data != null && response.status == 200) {
      response.data = (response.data as List)
          .map((i) => CategoryModel.fromJson(i))
          .toList();

      return response;
    }
    return response;
  }

  @override
  Future<ApiResponse> deleteProduct(int id) async {
    final response = await _apiBaseHelper.deleteHttp('productos/$id');

    if (response.data != null && response.status == 200) {
      response.data = true;
      return response;
    }
    response.data = false;
    return response;
  }

  @override
  Future<ApiResponse> addProduct(String name, String description, String price,
      String code, String state, int category) async {
    final response = await _apiBaseHelper.postHttp('productos', {
      "codigo": code,
      "estado": state == 'true' ? true : false,
      "precio": price,
      "producto": name,
      "descripcion": description,
      "idCategoria": category
    });

    if (response.data != null && response.status == 200) {
      response.data = (response.data as List)
          .map((i) => CategoryModel.fromJson(i))
          .toList();

      return response;
    }
    return response;
  }
}
