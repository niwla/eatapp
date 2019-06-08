import 'package:flutter/material.dart';
import 'package:app_eat/src/bloc/provider.dart';
import 'package:app_eat/src/bloc/mesas_bloc.dart';

import 'package:app_eat/src/models/mesa_model.dart';


class MesaPage extends StatefulWidget {

  @override
  _MesaPageState createState() => _MesaPageState();
}

class _MesaPageState extends State<MesaPage> {

  @override
  Widget build(BuildContext context) {
    final mesasBloc = Provider.mesasBloc(context);
    mesasBloc.cargarMesas();


    return Scaffold(
      body: //_crearListado2(productosBloc),
          _crearListado(mesasBloc),
    );
  }

  Widget _crearListado(MesasBloc mesasBloc) {

    
    return StreamBuilder(
      stream: mesasBloc.mesasStream,
      builder: (BuildContext context, AsyncSnapshot<List<MesaModel>> snapshot) {
        if (snapshot.hasData) {
          final mesas = snapshot.data;

          return ListView.builder(
            
            itemCount: mesas.length,
            itemBuilder: (context, i) =>
                _crearItem(context, mesasBloc, mesas[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, MesasBloc mesasBloc, MesaModel mesa,
      ) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('Mesa ${mesa.mesa} '),
              subtitle: Text(mesa.estado.toString()),
              onTap: () {
                Navigator.pushNamed(context, 'pedido', arguments: mesa);
              }
              // Navigator.pushNamed(context, 'pedido', arguments: pedido),
              //  onTap: () => _createNewProduct(context, mesasBloc, mesa),
              ),
        ],
      ),
    );
  }
}
