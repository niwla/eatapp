import 'package:app_eat/src/bloc/mesas_bloc.dart';
import 'package:app_eat/src/bloc/pedidos_bloc.dart';
import 'package:app_eat/src/bloc/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/src/bloc/login_bloc.dart';
export 'package:app_eat/src/bloc/login_bloc.dart';


class Provider extends InheritedWidget {

  final loginBloc      = new LoginBloc();
  final _mesasBloc     = new MesasBloc();
  final _pedidosBloc     = new PedidosBloc();
  final _productosBloc     = new ProductosBloc();
  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

    static MesasBloc mesasBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._mesasBloc;
  }
    static PedidosBloc pedidosBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._pedidosBloc;
  }

    static ProductosBloc productosBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._productosBloc;
  }
}