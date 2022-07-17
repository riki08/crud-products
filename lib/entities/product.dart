class ProductModel {
  ProductModel({
    required this.id,
    this.codigo,
    required this.estado,
    required this.precio,
    required this.producto,
    this.descripcion,
    required this.idCategoria,
    this.categoria,
  });

  final int id;
  final String? codigo;
  final bool estado;
  final String precio;
  final String producto;
  final String? descripcion;
  final int idCategoria;
  String? categoria;

  String get getCategory {
    return categoria!;
  }

  set setCategory(String name) {
    categoria = name;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        codigo: json["codigo"] ?? '',
        estado: json["estado"],
        precio: json["precio"],
        producto: json["producto"],
        descripcion: json["descripcion"] ?? '',
        idCategoria: json["idCategoria"],
        categoria: '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "estado": estado,
        "precio": precio,
        "producto": producto,
        "descripcion": descripcion,
        "idCategoria": idCategoria,
        "categoria": categoria,
      };
}
