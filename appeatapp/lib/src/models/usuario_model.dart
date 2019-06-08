import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    int id;
    String correo;
    String password;

    UsuarioModel({
        this.id,
        this.correo,
        this.password,
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => new UsuarioModel(
        id: json["id"],
        correo: json["correo"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
    //    "id": id,
        "correo": correo,
        "password": password,
    };
}