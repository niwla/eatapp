import 'package:app_eat/src/pages/mesa_page.dart';
import 'package:app_eat/src/pages/mispedidos_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex =0;
   callPage(int currentIndex){

      switch (currentIndex){
        case 0: return MesaPage();
        case 1: return MispedidosPage();
      }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Eat App')),
      body: //_crearListado2(productosBloc),
         // _crearListado(mesasBloc),
         callPage(_currentIndex),
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: _currentIndex,
           onTap: (value){
             _currentIndex=value;
             setState(() {
               
             });
           },
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.add_box),
               title: Text('Mesas')
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.assignment),
               title: Text('Pedidos')
             ),
           ],
         ),

    );
  }


}
