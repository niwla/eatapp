
import 'package:app_eat/src/providers/mesas_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app_eat/src/models/mesa_model.dart';




class MesasBloc {

  final _mesasController = new BehaviorSubject<List<MesaModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _mesasProvider   = new MesasProvider();


  Stream<List<MesaModel>> get mesasStream => _mesasController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarMesas() async {

    final mesas = await _mesasProvider.cargarMesas();
    _mesasController.sink.add( mesas );
  }

   void actualizarMesa( MesaModel mesa ) async {

    _cargandoController.sink.add(true);
    await _mesasProvider.actualizarMesa(mesa);
    _cargandoController.sink.add(false);

  }


  dispose() {
    _mesasController?.close();
    _cargandoController?.close();
  }

}