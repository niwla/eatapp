
import 'dart:convert';

MesaModel mesaModelFromJson(String str) => MesaModel.fromJson(json.decode(str));

String mesaModelToJson(MesaModel data) => json.encode(data.toJson());

class MesaModel {
    String id;
    int mesa;
    bool estado;

    MesaModel({
        this.id,
        this.mesa,
        this.estado = true,
    });

    factory MesaModel.fromJson(Map<String, dynamic> json) => new MesaModel(
        id: json["id"],
        mesa: json["mesa"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
    //    "id": id,
        "mesa": mesa,
        "estado": estado,
    };
}