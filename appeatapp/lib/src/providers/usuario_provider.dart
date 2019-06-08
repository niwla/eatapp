import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_eat/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_eat/src/models/usuario_model.dart';

class UsuarioProvider {

  final String _firebaseToken = '';
  final _prefs = new PreferenciasUsuario();
  final String _url = 'bdfirebase';

  Future<Map<String, dynamic>> login( String email, String password) async {

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      
      _prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'], /* 'userEmail': email */ };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }

  }


  Future<Map<String, dynamic>> nuevoUsuario( String email, String password, UsuarioModel usuario ) async {

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };


    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_firebaseToken',
       body: json.encode( authData ),
       );


   

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      
      _prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'], 'userEmail': email };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }


  }


  Future<bool> crearUsuario( UsuarioModel usuario  ) async {

    final url = '$_url/usuarios.json';
   // final url = '$_url/pedidos.json?auth=${ _prefs.token }';

    final resp = await http.post( url, body: usuarioModelToJson(usuario) );

    final  decodedData = json.decode(resp.body);

  
    return true;

  }



}