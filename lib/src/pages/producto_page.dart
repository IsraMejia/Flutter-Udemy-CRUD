// import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validaciones_crud/src/models/producto_model.dart';
import 'package:validaciones_crud/src/providers/productos_provider.dart';
import 'package:validaciones_crud/src/utils/utils.dart' as utils; //Forma de importarlo xd

class ProductoPage extends StatefulWidget {
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductoModel producto = new ProductoModel();
  final productoProvider = new ProductosProvider();

  bool _guardando =false;
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodArgData = ModalRoute.of(context).settings.arguments;
    //Se declara el prodArgData que recibe como argumento el producto seleccionado en el Homepage
    //en caso de que se construya la pagina y no venga el producto solo se recibe un null

    if(prodArgData != null){
      producto = prodArgData;
    } //Con solo esto ya se pone todo lo demas en automatico gracias al Initial Value

    return Scaffold(
      key: scaffoldKey,//El identificador del scaffold para el snackbar
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual),
           onPressed: _seleccionarFoto ,
          ),
          IconButton(icon: Icon(Icons.camera_alt ),
           onPressed: _tomarFoto ,
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
              _mostrarFoto(),
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
      onPressed: (_guardando)  ? null : _submit,
      //Si no ha sido presionado en esos momentos hace el sumit, de esta manera no se
      //hace la misma consulta varias veces
    );
  }

  void _submit(){
    if (! formKey.currentState.validate()){//Usa la llave global del form para validar sus datos
      return; //Si no es valido no hace nada xd, solo cambia el estado para pintar el error
    }
    formKey.currentState.save(); //Ahora si pasa la informacion para guardarse en el json

    if(producto.id == null){//Si no existe el ID de firebase
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }
    mostrarSnackBar('registro guardaado');
    
    setState(() {
      _guardando =false; //se guardo, ayudara a bloquear el boton
    });

    Navigator.pop(context);//te manda a la pagina anterior

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

  void mostrarSnackBar(String mensaje){
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2200),
    );

    //Se necesita hacer referencia al Scaffold porquesolo el puede pintar el appbar
    scaffoldKey.currentState.showSnackBar(snackBar);
    
  }//mostrarSnackBar()

  Widget _mostrarFoto(){
    if(producto.fotoUrl != null ){
      return Container(

      );
    }else{
      return  Image(
          image: AssetImage(   "assets/no-image.jpg"),
          //si la foto tiene un valor poner ese, si no el asstet
          height: 300.0,
          fit: BoxFit.cover,//mantiene dimensiones
        );
      
    }
  }


  _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery );

    setState(() {
      _image = File(pickedFile.toString());
    });

  }//_seleccionarFoto()


  Future  _tomarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.toString());
    });
  }//_tomarFoto()




}//class ProductoPage