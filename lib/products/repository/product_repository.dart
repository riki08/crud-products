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
    print('aca');

    final response = await _apiBaseHelper.getHttp('productos');

    if (response.data != null && response.status == 200) {
      response.data =
          (response.data as List).map((i) => ProductModel.fromJson(i)).toList();
      print('Antes del map');

      response.data.map((ProductModel product) {
        print('dentro del map');
        final category = categories
            .firstWhere((element) => element.id == product.idCategoria)
            .nombre;
        print(category);
        product.setCategory = category;
      }).toList();
      print('despues del map');
      print(response.data);
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
}
