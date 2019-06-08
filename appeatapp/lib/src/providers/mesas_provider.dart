import 'dart:convert';


//import 'package:app_eat/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import 'package:app_eat/src/models/mesa_model.dart';

class MesasProvider {

  final String _url = 'bdfirebase';
 // final _prefs = new PreferenciasUsuario();


  Future<List<MesaModel>> cargarMesas() async {

    final url  = '$_url/mesas.json';
   // final url  = '$_url/mesas.json?auth=${ _prefs.token }';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MesaModel> mesas = new List();


    if ( decodedData == null ) return [];

    if ( decodedData['error'] != null ) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = MesaModel.fromJson(prod);
      prodTemp.id = id;

      if (prodTemp.estado) {
        mesas.add( prodTemp );
      }

    });

    return mesas;

  }


    Future<bool> actualizarMesa( MesaModel mesa ) async {

    
    final url = '$_url/mesas/${ mesa.id }.json';
  //  final url = '$_url/pedidos/${ pedido.id }.json?auth=${ _prefs.token }';

    final resp = await http.put( url, body: mesaModelToJson(mesa) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



}

