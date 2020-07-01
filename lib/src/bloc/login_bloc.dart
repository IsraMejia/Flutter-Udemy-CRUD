import 'dart:async';

class LoginBloc{
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  //Permite recibir distintas cadenas y usar listeners
  //varias instancias pueden escuchar los cambios gracias al broadcast


  //Escuchar/Recuperar datos del string
  Stream<String> get emailStream   => _emailController.stream; 
  Stream<String> get passwordStram => _passwordController.stream;

  //Insertando valores al string
  //Se manda como referencia para ejecutarce despues, con parentesis, la ejecutaria al instante
  Function(String) get changeEmail    => _emailController.sink.add; 
  Function(String) get changePassword => _passwordController.sink.add; 


  //Cierra el flujo de datos cuando ya no se ocupa, se agrega el '?' para que en caso
  //de que sea null las cadenas no nos marque error
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}//LoginBloc