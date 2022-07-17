import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:products/products/bloc/products_bloc.dart';
import 'package:products/products/products_page.dart';

import 'package:products/utils/injector.dart';
import 'package:products/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Dependencies().repositoryRegister();
  Dependencies().blocsRegister();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => Injector.appInstance.get<ProductsBloc>()),
      ],
      child: MaterialApp(
        title: 'Products',
        debugShowCheckedModeBanner: false,
        home: const ProductsPage(),
        routes: MyRoutes.routes,
      ),
    );
  }
}
