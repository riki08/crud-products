import 'package:products/entities/api_response.dart';
import 'package:products/entities/category.dart';

abstract class ProductRepositoryIml {
  Future<ApiResponse> getProducts(List<CategoryModel> categories);
  Future<ApiResponse> getCategories();
}
