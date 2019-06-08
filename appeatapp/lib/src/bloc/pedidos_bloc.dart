
import 'package:app_eat/src/providers/pedidos_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app_eat/src/models/pedido_model.dart';




class PedidosBloc {

  final _pedidosController = new BehaviorSubject<List<PedidoModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _pedidosProvider   = new PedidosProvider();


  Stream<List<PedidoModel>> get pedidosStream => _pedidosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarPedidos() async {

    final pedidos = await _pedidosProvider.cargarPedidos();
    _pedidosController.sink.add( pedidos );
  }


  dispose() {
    _pedidosController?.close();
    _cargandoController?.close();
  }

}