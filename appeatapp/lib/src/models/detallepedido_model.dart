
import 'dart:convert';

DetallepedidoModel detallepedidoModelFromJson(String str) => DetallepedidoModel.fromJson(json.decode(str));

String detallepedidoModelToJson(DetallepedidoModel data) => json.encode(data.toJson());

class DetallepedidoModel {
    String id;
    String productoid;
    String pedidoid;

    DetallepedidoModel({
        this.id,
        this.productoid,
        this.pedidoid,
    });

    factory DetallepedidoModel.fromJson(Map<String, dynamic> json) => new DetallepedidoModel(
        id: json["id"],
        productoid: json["productoid"],
        pedidoid: json["pedidoid"],
    );

    Map<String, dynamic> toJson() => {
      //  "id": id,
        "productoid": productoid,
        "pedidoid": pedidoid,
    };
}