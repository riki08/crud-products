import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products/entities/product.dart';
import 'package:products/products/bloc/products_bloc.dart';
import 'package:products/products/widgets/form_page.dart';
import 'package:products/products/widgets/product_detail.dart';
import 'package:products/utils/responsive.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductsBloc _productBloc;

  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductsBloc>(context);
    _productBloc.add(GetProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData size = MediaQuery.of(context);
    ResponsiveUtil.setScreenSize(size);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Productos',
            style: TextStyle(fontSize: 6.w),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('form'),
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 4.h,
                ))
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return state.status.isSuccess
                ? state.products!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: ListView.builder(
                          itemCount: state.products!.length,
                          itemBuilder: (_, int index) {
                            final product = state.products![index];
                            return Dismissible(
                              key: ValueKey(product.id),
                              background: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10.w),
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                color: Colors.blueAccent,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 4.h,
                                    ),
                                    Text(
                                      'Editar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2.8.h),
                                    )
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 40.w),
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 4.h,
                                    ),
                                    Text(
                                      'Eliminar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2.8.h),
                                    )
                                  ],
                                ),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  _productBloc.add(DeleteProduct(product.id));
                                }
                                if (direction == DismissDirection.startToEnd) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormPage(
                                              productModel: product,
                                            )),
                                  );
                                }
                                setState(() {
                                  state.products!.removeAt(index);
                                });
                              },
                              child: ProductDetail(product: product),
                            );
                          },
                        ),
                      )
                    : const Text('No hay productos')
                : Text(state.errorMessage!);
          },
        ));
  }
}
