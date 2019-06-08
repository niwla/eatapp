import 'package:app_eat/src/pages/mesa_page.dart';
import 'package:app_eat/src/pages/mispedidos_page.dart';
import 'package:app_eat/src/pages/pedidolisto_page.dart';
import 'package:app_eat/src/pages/registro_page.dart';
import 'package:app_eat/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'package:app_eat/src/bloc/provider.dart';

import 'package:app_eat/src/pages/home_page.dart';
import 'package:app_eat/src/pages/login_page.dart';
import 'package:app_eat/src/pages/pedido_page.dart';
 
void main() async {

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final prefs = new PreferenciasUsuario();
    print( prefs.token );
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eat App',
        initialRoute: 'home',
        routes: {
          'login'       : ( BuildContext context ) => LoginPage(),
          'registro'    : ( BuildContext context ) => RegistroPage(),
          'home'        : ( BuildContext context ) => HomePage(),
          'mesa'        : ( BuildContext context ) => MesaPage(),
          'pedido'      : ( BuildContext context ) => PedidoPage(),
          'mispedidos'  : ( BuildContext context ) => MispedidosPage(),
          'pedidolisto'      : ( BuildContext context ) => PedidolistoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
      ),
    );
      
  }
}