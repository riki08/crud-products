import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import 'package:products/entities/product.dart';
import 'package:products/products/bloc/products_bloc.dart';
import 'package:products/products/widgets/form_page.dart';
import 'package:products/utils/responsive.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ProductsBloc _productBloc = BlocProvider.of<ProductsBloc>(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Field(
                title: 'Nombre del producto: ', description: product.producto),
            SizedBox(height: 0.6.h),
            if (product.descripcion != null) ...[
              Field(title: 'Descripción: ', description: product.descripcion!),
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
        ));
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
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 2.h),
        ),
        Text(
          description,
          style: TextStyle(color: Colors.black, fontSize: 2.h),
        ),
      ],
    );
  }
}
