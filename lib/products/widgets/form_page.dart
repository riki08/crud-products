import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products/products/bloc/products_bloc.dart';
import 'package:products/entities/product.dart';
import 'package:products/utils/responsive.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final productController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  late String? selectedState;
  late int? selectedCategory;
  final codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: 'true', child: Text("Activo")),
    DropdownMenuItem(value: "false", child: Text("Inactivo")),
  ];
  late List<DropdownMenuItem<int>> categories;

  @override
  void initState() {
    if (widget.productModel != null) {
      productController.text = widget.productModel!.producto;
      priceController.text = widget.productModel!.precio;
      descriptionController.text = widget.productModel!.descripcion ?? '';
      codeController.text = widget.productModel!.codigo ?? '';
      selectedState = widget.productModel!.estado ? 'true' : 'false';
      selectedCategory = widget.productModel!.idCategoria;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsBloc _productBloc = BlocProvider.of<ProductsBloc>(context);
    categories = _productBloc.getCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel != null ? 'Actualizar' : 'Crear'),
        leading: GestureDetector(
            onTap: () {
              if (widget.productModel != null) {
                _productBloc.add(GetProducts());
              }
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 1.8.h, left: 1.8.h),
        margin: EdgeInsets.only(top: 6.h),
        height: 100.h,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: productController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 2.h),
                        decoration: InputDecoration(
                          hintText: 'Nombre del producto',
                          hintStyle: TextStyle(
                              fontSize:
                                  ResponsiveUtil.zoom < 1.2 ? 2.h : 1.8.h),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 3.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Este campo es obligatorio';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        controller: descriptionController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontSize: 2.h),
                        decoration: InputDecoration(
                          hintText: 'descripcion del producto',
                          hintStyle: TextStyle(
                              fontSize:
                                  ResponsiveUtil.zoom < 1.2 ? 2.h : 1.8.h),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 3.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        controller: priceController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 2.h),
                        decoration: InputDecoration(
                          hintText: 'precio del producto',
                          hintStyle: TextStyle(
                              fontSize:
                                  ResponsiveUtil.zoom < 1.2 ? 2.h : 1.8.h),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 3.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Este campo es obligatorio';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        controller: codeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 2.h),
                        decoration: InputDecoration(
                          hintText: 'codigo del producto',
                          hintStyle: TextStyle(
                              fontSize:
                                  ResponsiveUtil.zoom < 1.2 ? 2.h : 1.8.h),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 3.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      DropdownButtonFormField(
                        value: selectedState,
                        hint: Text('Estado del producto'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        )),
                        validator: (value) =>
                            value == null ? "Campo obligatorio" : null,
                        items: menuItems,
                        onChanged: (String? value) {
                          selectedState = value!;
                        },
                      ),
                      SizedBox(height: 2.h),
                      DropdownButtonFormField(
                        value: selectedCategory,
                        hint: Text('Categoria'),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        )),
                        validator: (value) =>
                            value == null ? "Campo obligatorio" : null,
                        items: categories,
                        onChanged: (int? value) {
                          selectedCategory = value!;
                          print(selectedCategory);
                        },
                      ),
                      SizedBox(height: 1.5.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.productModel != null) {
                                _productBloc.add(UpdateProduct(
                                    widget.productModel!.id,
                                    productController.text,
                                    descriptionController.text,
                                    priceController.text,
                                    codeController.text,
                                    selectedState!,
                                    selectedCategory!, () {
                                  Navigator.of(context).pop();
                                  _productBloc.add(GetProducts());
                                }));
                              } else {
                                _productBloc.add(AddProduct(
                                    productController.text,
                                    descriptionController.text,
                                    priceController.text,
                                    codeController.text,
                                    selectedState!,
                                    selectedCategory!, () {
                                  Navigator.of(context).pop();
                                  _productBloc.add(GetProducts());
                                }));
                              }
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: Text(widget.productModel != null
                              ? 'Actualizar'
                              : 'Crear'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
