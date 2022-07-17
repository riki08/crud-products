import 'package:products/entities/api_response.dart';
import 'package:products/entities/category.dart';

abstract class ProductRepositoryIml {
  Future<ApiResponse> getProducts(List<CategoryModel> categories);
  Future<ApiResponse> deleteProduct(int id);
  Future<ApiResponse> addProduct(String name, String description, String price,
      String code, String state, int category);
  Future<ApiResponse> getCategories();
}
