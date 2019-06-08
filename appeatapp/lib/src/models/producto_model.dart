import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String nombre;
    int valor;
    String descripcion;
    int tipoid;

    ProductoModel({
        this.id,
        this.nombre,
        this.valor,
        this.descripcion,
        this.tipoid,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel(
        id: json["id"],
        nombre: json["nombre"],
        valor: json["valor"],
        descripcion: json["descripcion"],
        tipoid: json["tipoid"],
    );

    Map<String, dynamic> toJson() => {
     //   "id": id,
        "nombre": nombre,
        "valor": valor,
        "descripcion": descripcion,
        "tipoid": tipoid,
    };
}
