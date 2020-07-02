import 'package:flutter/material.dart';
import 'package:validaciones_crud/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page xD'),
      ),
      body: Container(),
      floatingActionButton: _crearBoton(context),
      
    );
  }//build

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed:()=> Navigator.pushNamed(context, 'producto') ,
      child: Icon(Icons.shopping_cart),
      backgroundColor: Colors.deepPurple[500],
      );
  }
}