import 'package:flutter/material.dart';

class ProductoPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual),
           onPressed: (){} 
          ),
          IconButton(icon: Icon(Icons.camera_alt ),
           onPressed: (){} 
          )
        ],
      ),
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form( //Similar a un container, pero ayuda a validar la informacion que contiene
          child: Column(
            children: <Widget>[
              _crearNombre(),
              _crearPrecio(),
              _crearBoton()
            ],
          )
        ),
      ),
    ),
    );
  }//build

  Widget _crearNombre(){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
    );
  }


  Widget _crearPrecio(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
    );
  }

  Widget _crearBoton() {
    return  RaisedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple[500] ,
      textColor: Colors.blueGrey[50],
      onPressed: (){},
    );
  }

}//class ProductoPage