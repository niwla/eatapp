import 'package:flutter/material.dart';
import 'package:app_eat/src/bloc/provider.dart';
import 'package:app_eat/src/bloc/pedidos_bloc.dart';

import 'package:app_eat/src/models/pedido_model.dart';


class MispedidosPage extends StatefulWidget {

  @override
  _MispedidosPageState createState() => _MispedidosPageState();
}

class _MispedidosPageState extends State<MispedidosPage> {

  @override
  Widget build(BuildContext context) {
    final pedidosBloc = Provider.pedidosBloc(context);
    pedidosBloc.cargarPedidos();


    return Scaffold(
      body: //_crearListado2(productosBloc),
          _crearListado(pedidosBloc),
    );
  }

  Widget _crearListado(PedidosBloc pedidosBloc) {

    
    return StreamBuilder(
      stream: pedidosBloc.pedidosStream,
      builder: (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot) {
        if (snapshot.hasData) {
          final pedidos = snapshot.data;

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, pedidosBloc, pedidos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, PedidosBloc pedidosBloc, PedidoModel pedido,
      ) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('Pedido ${pedido.mesasnum} '),
              onTap: () {
                Navigator.pushNamed(context, 'pedidolisto', arguments: pedido);
              }
              // Navigator.pushNamed(context, 'pedido', arguments: pedido),
              //  onTap: () => _createNewProduct(context, mesasBloc, mesa),
              ),
        ],
      ),
    );
  }
}
