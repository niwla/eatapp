
import 'package:app_eat/src/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app_eat/src/models/producto_model.dart';




class ProductosBloc {

  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _productosProvider   = new ProductosProvider();


  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarProductos() async {

    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add( productos );
  }


  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }

}