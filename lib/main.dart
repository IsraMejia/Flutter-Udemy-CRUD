import 'package:flutter/material.dart';
import 'package:validaciones_crud/src/bloc/provider.dart';
import 'package:validaciones_crud/src/pages/home_page.dart';
import 'package:validaciones_crud/src/pages/login_page.dart';
import 'package:validaciones_crud/src/pages/producto_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ValidacionesCRUD',
        initialRoute: 'home',
        routes: {
          'login'   : (BuildContext context ) => LoginPage(),
          'home'    : (BuildContext context ) => HomePage(),
          'producto': (BuildContext context ) => ProductoPage(),
        },//routes
        theme: ThemeData(
          primaryColor: Colors.deepPurple[900],
          //Los colores de los widgets material ahora son morados
        ),
      ),
    );
    
  }//build
}//MyApp