
import 'dart:convert';//para josn.decode
//Se agrego en el pubspec el paquete "http" para que jale
import 'package:http/http.dart' as http; //para acceder a los metodos con la palabra http

import 'package:validaciones_crud/src/models/producto_model.dart';

class ProductosProvider{
  final String _url ='https://fluttercrud-d1c8b.firebaseio.com';
  //la raiz de la base de datos en firebase, nos permitira usar la REST API

  Future<bool> crearProducto (ProductoModel producto)  async  {
    final url ='$_url/productos.json'; //Aqui se hara la peticion POST para insertar un nuevo registro
    final resp =  await  http.post(url, body: productoModelToJson(producto) );
    //Se manda el produto en string porque asi lo pide firebase

    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }


  Future<bool> editarProducto (ProductoModel producto)  async  {
    final url ='$_url/productos/${producto.id}.json'; 
    final resp =  await  http.put(url, body: productoModelToJson(producto) );
    //Aqui se hara la peticion PUT para remplazar el registro 

    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }


  Future<List<ProductoModel>> cargarProductos()  async {
    final url = '$_url/productos.json';
    final resp = await  http.get(url);
    final List<ProductoModel> productos = new List();

    final Map<String , dynamic> decodedData = json.decode(resp.body);
    
    if(decodedData == null){
      return [];
    }

    decodedData.forEach((id, prod,){
      // print(prod);
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });

    print(productos );

    return productos; //retorna una lista vacia
  }


  Future <int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json'; //El http especifico del producto
    final resp = await  http.delete(url);

    print(resp.body );

    return 1;
  }



}