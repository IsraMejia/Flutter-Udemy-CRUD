import 'dart:async';

import 'package:validaciones_crud/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{ //Se crea el mixing con el Validators

  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();
  //Permite recibir distintas cadenas y usar listeners
  //varias instancias pueden escuchar los cambios gracias al broadcast

  final _emailController = BehaviorSubject <String>();
  final _passwordController = BehaviorSubject <String>();
  //La libreria rxdart usa BehaviorSubject que tienen su broadcast interno por defecto



  //Escuchar/Recuperar datos del string
  Stream<String> get emailStream   => _emailController.stream.transform(validarEmail) ;
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  // .transform perdmite recibir la informacion despues de la validacion, si  no no

  Stream<bool> get formValidStream =>
       Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  //Cuando ambos streams son validados, se hace el callback, en caso de que en ambos haya data se manda un true
  //Esto valida que tanto el correo como la constraseña sean validos al mismo tiempo


  //Insertando valores al string
  //Se manda como referencia para ejecutarce despues, con parentesis, la ejecutaria al instante
  Function(String) get changeEmail    => _emailController.sink.add; 
  Function(String) get changePassword => _passwordController.sink.add; 


  //Obtener el ultimo valor ingresado
  String get email => _emailController.value;
  String get password => _passwordController.value;



  //Cierra el flujo de datos cuando ya no se ocupa, se agrega el '?' para que en caso
  //de que sea null las cadenas no nos marque error
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}//LoginBloc