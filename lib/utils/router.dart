import 'package:products/products/products_page.dart';
import 'package:products/products/widgets/form_page.dart';

class MyRoutes {
  static final routes = {
    'products': (context) => const ProductsPage(),
    'form': (context) => FormPage(),
    // 'users': (context) => const UserListPage(),
    // 'details': (context) => const DetailsUser(),
  };
}
