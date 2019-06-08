import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_eat/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_eat/src/models/detallepedido_model.dart';
import 'package:app_eat/src/models/pedido_model.dart';

class PedidosProvider {

  final String _url = 'bdfirebase';
  final _prefs = new PreferenciasUsuario();


  Future<bool> crearPedido( PedidoModel pedido, DetallepedidoModel detallepedido  ) async {

    final url = '$_url/pedidos.json';
  //  final url2 = '$_url/detallepedidos.json';
   // final url = '$_url/pedidos.json?auth=${ _prefs.token }';

    final resp = await http.post( url, body: pedidoModelToJson(pedido) );
  //  final resp2 = await http.post( url2, body: detallepedidoModelToJson(detallepedido) );

   // final resp2 = await http.post( url2, body: detallepedidoModelToJson(detallepedido) );
    final  decodedData = json.decode(resp.body);
 //  final  decodedData2 = json.decode(resp2.body);
  
 
    return true;

  }

  Future<bool> editarPedido( PedidoModel pedido ) async {

    
    final url = '$_url/pedidos/${ pedido.id }.json';
  //  final url = '$_url/pedidos/${ pedido.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: pedidoModelToJson(pedido) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



  Future<List<PedidoModel>> cargarPedidos() async {

    final url = '$_url/pedidos.json';
  //  final url  = '$_url/pedidos.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<PedidoModel> pedidos = new List();


    if ( decodedData == null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = PedidoModel.fromJson(prod);
      prodTemp.id = id;


     if (prodTemp.estado) {
        pedidos.add( prodTemp );
      }

    });



    return pedidos;

  }


  Future<int> borrarPedido( String id ) async { 

    

    final url  = '$_url/pedidos/$id.json?auth=${ _prefs.token }';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }


    Future<bool> actualizarPedido( PedidoModel pedido ) async {

    
    final url = '$_url/pedidos/${ pedido.id }.json';
  //  final url = '$_url/pedidos/${ pedido.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: pedidoModelToJson(pedido) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



}

