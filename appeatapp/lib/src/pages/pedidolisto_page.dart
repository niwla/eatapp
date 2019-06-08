
import 'package:app_eat/src/bloc/pedidos_bloc.dart';
import 'package:app_eat/src/bloc/provider.dart';
import 'package:app_eat/src/models/detallepedido_model.dart';
import 'package:app_eat/src/models/mesa_model.dart';
import 'package:app_eat/src/models/producto_model.dart';
import 'package:app_eat/src/providers/detallepedidos_provider.dart';
import 'package:app_eat/src/providers/mesas_provider.dart';
import 'package:app_eat/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';


import 'package:app_eat/src/models/pedido_model.dart';
import 'package:app_eat/src/providers/pedidos_provider.dart';


class PedidolistoPage extends StatefulWidget {
  @override
  _PedidolistoPageState createState() => _PedidolistoPageState();
}

class _PedidolistoPageState extends State<PedidolistoPage> {
  PedidoModel pedido = new PedidoModel();
  MesaModel mesa = new MesaModel();
  ProductoModel producto = new ProductoModel();
  DetallepedidoModel detallepedido = new DetallepedidoModel();


  String now = DateTime.now().toString().substring(0, 10);
  String hora = DateTime.now().toString().substring(11, 19);




  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pedidoProvider = new PedidosProvider();
  final productoProvider = new ProductosProvider();
  final mesaProvider = new MesasProvider();
  final detallepedidoProvider = new DetallepedidosProvider();


  PedidosBloc pedidosBloc;


  bool _guardando = false;


  @override
  Widget build(BuildContext context) {

    pedidosBloc = Provider.pedidosBloc(context);

    final PedidoModel prodData = ModalRoute.of(context).settings.arguments;
    pedido = prodData;
    

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Pedidos Mesa ${pedido.mesasnum}'),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text('Numero de clientes : ${pedido.numclientes}'),
                //   Text('${productoData.nombre}'),
                Text('Productos : ${pedido.productoid}'),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }



  List<DropdownMenuItem> _getMenuItems(List<ProductoModel> products) {
    List<DropdownMenuItem> items = List<DropdownMenuItem>();
    products.forEach((product) {
      items.add(DropdownMenuItem(
        child: Text(product.nombre),
        value: product.nombre,
      ));
    });
    return items;
  }



  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.redAccent,
      textColor: Colors.white,
      label: Text('Finalizar pedido'),
      icon: Icon(Icons.save),
      onPressed: (_guardando)
          ? null
          : () {
              _submit();
            },
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

      mesa.mesa = pedido.mesasnum;
      mesa.id = pedido.mesaid;
      mesa.estado = true;
      mesaProvider.actualizarMesa(mesa);
      pedido.estado = false;
      pedidoProvider.actualizarPedido(pedido);



    Navigator.pop(context);
  }




}
