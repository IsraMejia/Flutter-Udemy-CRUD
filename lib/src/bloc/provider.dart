import 'package:flutter/material.dart';// InheritedWidget
import 'package:validaciones_crud/src/bloc/login_bloc.dart';

export 'package:validaciones_crud/src/bloc/login_bloc.dart';
//Para que donde sea que se use el provider vaya con él el login bloc

class Provider extends InheritedWidget {
//Todo esto sirve para 

  //Para no perder la informacion se hara uso de un factory
  static Provider _instancia;
  factory Provider ({Key key,  Widget child}){
    if(_instancia == null){
      _instancia =new Provider._internal(key: key, child: child) ;
    }
    return _instancia;
    /*Si ya se tenia la instancia se manda en el hotreload para que no se pierda sus datos
    caso contrario se crea */
  }

  Provider._internal( {Key key,  Widget child} ) 
    : super (key : key , child : child);
  
  final loginBloc = LoginBloc(); 

  //Al inicializarla asi, con cada hotreload se perdia los streams (email, contraseña)
  // Provider( {Key key,  Widget child} ) 
  //   : super (key : key , child : child);
  //Constructor que manda a llamar la clase padre para asignar su llave y su hijo

  

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  //Al actualizarse debe notificar a sus hijos, si no se quiere se pone false

  // static LoginBloc of (BuildContext context){
  //   return (context.inheritFromWidgetOfExactType( Provider) as Provider).loginBloc;
  //   //Toma el contexto del arbol de widgets y busca el widget con el mismo tipo Provider (class Provider)
  //   //esto para retornar el estado del loginBloc (final loginBloc )
  // }

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
    //Toma el contexto del arbol de widgets y busca el widget con el mismo tipo Provider (class Provider)
    //esto para retornar el estado del loginBloc (final loginBloc )
  }

}