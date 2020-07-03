import 'package:flutter/material.dart';
import 'package:validaciones_crud/src/bloc/provider.dart';
import 'package:validaciones_crud/src/models/producto_model.dart';
import 'package:validaciones_crud/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider =  new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page xD'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
      
    );
  }//build

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos() ,
      
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context , i) => _crearItem(context ,productos[i] ) ,
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context ,ProductoModel producto){
    return 
      Dismissible(//borra visualmente y del dispositivo
        key: UniqueKey(),
        background: Container(
          color: Colors.deepOrange[800],
        ),
        onDismissed: (direccion){
          productosProvider.borrarProducto(producto.id);
        },//lo borra de firebase
        child: ListTile(
          title: Text('${producto.titulo}  -  ${producto.valor }'),
          subtitle: Text(producto.id),
          onTap: () => Navigator.pushNamed(
            context, 'producto',
            arguments: producto //Se manda el producto entero para que se pueda modificar
          ),
        ),
    );
  }


  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed:()=> Navigator.pushNamed(context, 'producto') ,
      child: Icon(Icons.add ),
      backgroundColor: Colors.deepPurple[500],
      );
  }
}