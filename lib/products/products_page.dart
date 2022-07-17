import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import 'package:products/entities/product.dart';
import 'package:products/products/bloc/products_bloc.dart';
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
          'Products',
          style: TextStyle(fontSize: 6.w),
        )),
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
                            return ProductDetail(
                                product: state.products![index]);
                          },
                        ),
                      )
                    : const Text('No hay productos')
                : Text(state.errorMessage!);
          },
        ));
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(color: Colors.white, fontSize: 2.8.h),
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
              style: TextStyle(color: Colors.white, fontSize: 2.8.h),
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          print('end to star');
        }
        if (direction == DismissDirection.startToEnd) {
          print('star to end');
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          margin: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
              color: Colors.blueGrey, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Field(
                  title: 'Nombre del producto: ',
                  description: product.producto),
              SizedBox(height: 0.6.h),
              if (product.descripcion != null) ...[
                Field(
                    title: 'Descripción: ', description: product.descripcion!),
              ],
              SizedBox(height: 0.6.h),
              Field(
                  title: 'Estado: ',
                  description: product.estado ? 'Activo' : 'Inactivo'),
              SizedBox(height: 0.6.h),
              Field(
                title: 'Categoria: ',
                description: product.getCategory,
              ),
              SizedBox(height: 0.6.h),
              Field(
                title: 'Precio: ',
                description:
                    '\$${intl.NumberFormat.decimalPattern().format(double.parse(product.precio))}',
              ),
            ],
          )),
    );
  }
}

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 2.h),
        ),
        Text(
          description,
          style: TextStyle(color: Colors.white, fontSize: 2.h),
        ),
      ],
    );
  }
}
