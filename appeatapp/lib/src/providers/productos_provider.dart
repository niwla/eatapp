import 'dart:convert';

//import 'package:app_eat/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;


import 'package:app_eat/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'bdfirebase';
 // final _prefs = new PreferenciasUsuario();


  Future<List<ProductoModel>> cargarProductos() async {

    final url  = '$_url/productos.json';
   // final url  = '$_url/productos.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();


    if ( decodedData == null ) return [];

    if ( decodedData['error'] != null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add( prodTemp );

    });

    return productos;

  }

//nuevos

    Future<bool> editarProductos( ProductoModel producto ) async {

    final url = '$_url/productos.json';
  //  final url = '$_url/productos/${ producto.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }


    Future<bool> crearProducto( ProductoModel producto ) async {

    final url = '$_url/productos.json';
   // final url = '$_url/productos.json?auth=${ _prefs.token }';

    final resp = await http.post( url, body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



}

