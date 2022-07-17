import 'package:injector/injector.dart';
import 'package:products/products/bloc/products_bloc.dart';
import 'package:products/products/repository/product_repository.dart';
import 'package:products/products/repository_iml/product_repository_iml.dart';

import 'package:products/utils/api_helper.dart';

class Dependencies {
  final injector = Injector.appInstance;

  blocsRegister() {
    injector.registerSingleton<ProductsBloc>(
        () => ProductsBloc(injector.get<ProductRepositoryIml>()));
  }

  repositoryRegister() {
    injector.registerSingleton<ApiBaseHelper>(() => ApiBaseHelper());

    injector.registerDependency<ProductRepositoryIml>(
        () => ProductRepository(injector.get<ApiBaseHelper>()));
  }
}
