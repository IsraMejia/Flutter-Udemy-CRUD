

import 'dart:async';

class Validators{
  
  final validarPassword = StreamTransformer<String , String>.fromHandlers(
    handleData: (password, sink){
      if (password.length >= 6){
        sink.add(password); //hacepta el passwor, lo agrega y lo deja fluir en el stream
      }else{
        sink.addError('Contraseña muy corta');
      }
    }  //handle = manejando data
  ); 


  final validarEmail = StreamTransformer<String , String>.fromHandlers(
    handleData: (email, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      // pattern es la expresion regular que valida al correo.
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('Email no valido');
      }
    }  //handle = manejando data
  ); 

  


} 