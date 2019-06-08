import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:app_eat/src/models/detallepedido_model.dart';

class DetallepedidosProvider {

  final String _url = 'bdfirebase';



  Future<List<DetallepedidoModel>> cargarDetallepedidos() async {

    final url = '$_url/detallepedidos.json';
  //  final url  = '$_url/pedidos.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<DetallepedidoModel> detallepedidos = new List();


    if ( decodedData == null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = DetallepedidoModel.fromJson(prod);
      prodTemp.id = id;

      detallepedidos.add( prodTemp );

    });

    return detallepedidos;

  }


  Future<bool> crearDetallepedido( DetallepedidoModel detallepedido ) async {

    final url = '$_url/detallepedidos.json';

   // final url = '$_url/pedidos.json?auth=${ _prefs.token }';

    final resp = await http.post( url, body: detallepedidoModelToJson(detallepedido) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> editarDetallepedido( DetallepedidoModel detallepedido ) async {

    
    final url = '$_url/detallepedido/${ detallepedido.id }.json';
  //  final url = '$_url/pedidos/${ pedido.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: detallepedidoModelToJson(detallepedido) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> actualizarDetallepedido( DetallepedidoModel detallepedido ) async {

    
    final url = '$_url/detallepedidos/${ detallepedido.id }.json';
  //  final url = '$_url/pedidos/${ pedido.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: detallepedidoModelToJson(detallepedido) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



}

