
import 'package:app_eat/src/bloc/productos_bloc.dart';
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


class PedidoPage extends StatefulWidget {
  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  PedidoModel pedido = new PedidoModel();
  MesaModel mesa = new MesaModel();
  ProductoModel producto = new ProductoModel();
  DetallepedidoModel detallepedido = new DetallepedidoModel();


  int numcli = 0;
  int numpro = 1;

  String now = DateTime.now().toString().substring(0, 10);
  String hora = DateTime.now().toString().substring(11, 19);
  String opcionProducto = 'Cazuela';



  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pedidoProvider = new PedidosProvider();
  final productoProvider = new ProductosProvider();
  final mesaProvider = new MesasProvider();
  final detallepedidoProvider = new DetallepedidosProvider();

  bool _guardando = false;

  void onMas() {
    setState(() {
      numcli++;
    });
  }

  void onMenos() {
    setState(() {

      if(numcli >= 1)
      {numcli--;}
      
    });
  }

    void onMasprod() {
    setState(() {
      numpro++;
    });
  }

  void onMenosprod() {
    setState(() {

      if(numpro >= 2)
      {numpro--;}
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final MesaModel mesaData = ModalRoute.of(context).settings.arguments;

    final opcionMesa = mesaData.id;
    final opcionNombre = mesaData.mesa;

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

  
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Pedidos Mesa ${mesaData.mesa}'),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                //   Text('${productoData.nombre}'),
                _cantidadClientes(),
                _crearTabla(),//productosBloc
                _crearBoton(mesaData.mesa,mesaData.id, opcionMesa, opcionNombre)
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _crearTabla() {

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
 
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text('Producto'),
        ),
        
        DataColumn(
          label: Text('Cantidad'),
        ),


      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              _crearDropdown(productosBloc),
            ),
            DataCell(
              _cantidadProductos()
              //_crearCantidad(),
            ),

          ]
        )

      ],
    );
  }

  ListTile myRowDataIcon(IconData iconVal, String rowVal){

    return ListTile(
      title: Text(rowVal, style:TextStyle(
        color: Colors.black
      )),
    );

  }

  Widget _cantidadProductos(){

    return Row(
      children: <Widget>[
        _restarProductos(),
        Text(numpro.toString()),
        
        _sumarProductos(),
      ],
    );

  }

    Widget _cantidadClientes(){

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Numero de clientes :'),
            _restarClientes(),
            Text(numcli.toString()),
            
            _sumarClientes(),
          ],
        ),
      ],
    );

  }

  Widget _crearDetalle() {

    return TextFormField(
      decoration: InputDecoration(
        labelText: ''
      ),
      onSaved: (value) => producto.descripcion = value,
      validator: (value) {
        if ( value.length < 3 ) {
          return 'detalle del producto';
        } else {
          return null;
        }
      },
    );
  }


   Widget _sumarProductos() {
     
    return new FlatButton(
      child: Text('+',textScaleFactor: 2.0,),
          onPressed: onMasprod,
          );
  }

   Widget _restarProductos() {
     
    return new FlatButton(
      child: Text('-',textScaleFactor: 2.0,),
          onPressed: onMenosprod,
          );
  }

     Widget _sumarClientes() {
     
    return new FlatButton(
      child: Text('+',textScaleFactor: 2.0,),
          onPressed: onMas,
          );
  }

   Widget _restarClientes() {
     
    return new FlatButton(
      child: Text('-',textScaleFactor: 2.0,),
          onPressed: onMenos,
          );
  }

    Widget _crearDropdown(ProductosBloc productos) {
    return StreamBuilder(
      builder: (context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        return DropdownButton(
          items: _getMenuItems(snapshot.data),
          onChanged: (value) {
            setState(() {
              opcionProducto = value;
            });
          },
        );
      },
      initialData: null,
      stream: productos.productosStream,
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



  Widget _crearBoton(int mesaId, String idmesa, opcionMesa, opcionNombre) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.redAccent,
      textColor: Colors.white,
      label: Text('Terminar pedido'),
      icon: Icon(Icons.save),
      onPressed: (_guardando)
          ? null
          : () {
              _submit(mesaId,idmesa, opcionMesa, opcionNombre);
            },
    );
  }

  void _submit( int mesaId,idmesa, opcionMesa, opcionNombre) async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (pedido.id == null ) {

      pedido.numclientes = numcli.toString();
      pedido.fecha = now;
      pedido.hora = hora;
      pedido.productoid = opcionProducto;
      pedido.mesasnum = mesaId;
      pedido.mesaid = idmesa;
      pedido.estado = true;
      mesa.id = opcionMesa;
      mesa.estado = false;
      mesa.mesa = opcionNombre;
      mesaProvider.actualizarMesa(mesa);
      
      detallepedido.productoid = opcionProducto;
      pedidoProvider.crearPedido(pedido,detallepedido);

      
      
      detallepedido.pedidoid = pedido.id;
      detallepedidoProvider.crearDetallepedido(detallepedido);
      
      
    } 


    Navigator.pop(context);
  }

}
