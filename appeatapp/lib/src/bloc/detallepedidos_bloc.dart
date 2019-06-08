
import 'package:app_eat/src/providers/detallepedidos_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app_eat/src/models/detallepedido_model.dart';




class DetallepedidosBloc {

  final _detallepedidosController = new BehaviorSubject<List<DetallepedidoModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _detallepedidosProvider   = new DetallepedidosProvider();


  Stream<List<DetallepedidoModel>> get detallepedidosStream => _detallepedidosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarDetallepedidos() async {

    final detallepedidos = await _detallepedidosProvider.cargarDetallepedidos();
    _detallepedidosController.sink.add( detallepedidos );
  }

  void actualizarDetallepedido( DetallepedidoModel detallepedido ) async {

    _cargandoController.sink.add(true);
    await _detallepedidosProvider.actualizarDetallepedido(detallepedido);
    _cargandoController.sink.add(false);

  }


  dispose() {
    _detallepedidosController?.close();
    _cargandoController?.close();
  }

}