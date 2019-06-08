// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

PedidoModel pedidoModelFromJson(String str) => PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());

class PedidoModel {
    String id;
    String numclientes;
    String fecha;
    String hora;
    int total;
    int mesasnum;
    bool estado;
    String mesaid;
    String productoid;

    PedidoModel({
        this.id,
        this.numclientes,
        this.fecha,
        this.hora,
        this.total,
        this.mesasnum,
        this.estado,
        this.mesaid,
        this.productoid,
    });

    factory PedidoModel.fromJson(Map<String, dynamic> json) => new PedidoModel(
        id: json["id"],
        numclientes: json["numclientes"],
        fecha: json["fecha"],
        hora: json["hora"],
        total: json["total"],
        mesasnum: json["mesasnum"],
        estado: json["estado"],
        mesaid: json["mesaid"],
        productoid: json["productoid"],
    );

    Map<String, dynamic> toJson() => {
    //    "id": id,
        "numclientes": numclientes,
        "fecha": fecha,
        "hora ": hora,
        "total": total,
        "mesasnum": mesasnum,
        "estado": estado,
        "mesaid": mesaid,
        "productoid": productoid,
    };

 
}
