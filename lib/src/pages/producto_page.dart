import 'package:flutter/material.dart';
import 'package:validaciones_crud/src/models/producto_model.dart';
import 'package:validaciones_crud/src/providers/productos_provider.dart';
import 'package:validaciones_crud/src/utils/utils.dart' as utils; //Forma de importarlo xd

class ProductoPage extends StatefulWidget {
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  ProductoModel producto = new ProductoModel();
  final productoProvider = new ProductosProvider();

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
          key: formKey ,
          child: Column(
            children: <Widget>[
              _crearNombre(),
              _crearPrecio(),
              _crearDisponible(),
              _crearBoton()
            ],
          )
        ),
      ),
    ),
    );
  }
  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved:(value) =>  producto.titulo = value , //Solo se ejecuta despues de validar el cambio
      validator: (value){
        if(value.length < 3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) =>  producto.valor = double.parse(value),
      validator: (value){
        if ( utils.esNumero(value) ){
          return null; //Es numero y pasa la validacion
        }else{
          return 'Solo Numeros';
        }
      },
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
      onPressed: _submit,//Se dispara cuando se apriete
    );
  }

  void _submit(){
    if (! formKey.currentState.validate()){//Usa la llave global del form para validar sus datos
      return; //Si no es valido no hace nada xd, solo cambia el estado para pintar el error
    }
    formKey.currentState.save(); //Ahora si pasa la informacion para guardarse en el json
    print('las entradas son validas');
    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);

    productoProvider.crearProducto(producto);

  }

  _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible , 
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      })
    );
  }


}//class ProductoPage