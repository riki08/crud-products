// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.nombre,
    required this.tipo,
  });

  final int id;
  final String nombre;
  final String tipo;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
      };
}
