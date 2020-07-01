
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:validaciones_crud/src/bloc/login_bloc.dart';
import 'package:validaciones_crud/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      )
    );
  }// build

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size; //Para obtener el alto de la pantalla

    final fondoMorado = Container(
      height: size.height * 0.4,//40% de la pantalla sera el tamaño del container
      width: double.infinity,//todo el ancho de la pantalla xd
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Colors.deepPurple[900],
          ]
        )
      ),
    );//fondo morado

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, .05)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( child: circulo,   top: 80.0,left: 30.0,),
        Positioned( child: circulo,   top: -50.0, right: -50.0,),
        Positioned( child: circulo,   bottom: -50.0, right: -10.0,),
        Positioned( child: circulo,   bottom: 120.0, right: 20.0,),
        Positioned( child: circulo,   bottom: -50.0, left: -27.0,),

        Container(
          padding: EdgeInsets.only(top: size.height * 0.1),
          child: Column(
            
            children: <Widget>[

              Icon(Icons.person_pin, color: Colors.white70 , size: 100.0,),
              SizedBox(height: 10.0, width:double.infinity ),
              //Al tener un Sizebox que usa todo el ancho, centra la columna
              Text('Iniciar Sesión', style: TextStyle( color: Colors.blueGrey[50], fontSize: 25.0))
            ],
          ),
        )
        
      ],
    );
  }//_crearFondo


  Widget _loginForm(BuildContext context){
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView( //Permetira poner todo lo demas de la pantalla con el teclado
      
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.29 ,
        )),
          
          Container(
            width: size.width * 0.85  ,
            padding: EdgeInsets.symmetric(vertical: 50.0), //Separaciones internas verticales
            margin: EdgeInsets.symmetric(vertical: 5),//Separaciones Externas verticales
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 3.0 ,
                  color: Colors.black26,
                  offset: Offset( 0.0, 3.0  ) // Para dejarlo ligeramente abajo
                  )
              ] ,
              color: Colors.blueGrey[50] ,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height:40.0),
                _crearEmail(bloc),
                SizedBox(height:10.0),
                _crearPassword(bloc),
                SizedBox(height:10.0),
                _crearBoton()
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0),
        ],
      ),

    );
  }


  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(
    //Permite escuchar los cambios que suceden en ese stream y poder reaccionar en base a ellos

      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress ,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo Electronico',
            counterText: snapshot.data
          ) ,
        onChanged: (value) => bloc.changeEmail(value),
        //manda el valor de la cadena que acaba de cambiar
        ),
      );
      },
    );
  }//crearEmail

  Widget _crearPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStram,
      builder: (BuildContext context, AsyncSnapshot snapshot ){
      return Container(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          obscureText: true,//Oculta el texto de entrada
          decoration: InputDecoration(
            icon: Icon( Icons.lock_outline , color: Colors.deepPurple ),
            labelText: 'Contraseña',
            counterText: snapshot.data
          ) ,
          onChanged: bloc.changePassword,
        ),
      );
      },
    );
  }//crearPassword

  Widget _crearBoton(){
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      elevation: 0.5,//Sin sombra que tiene por defecto
      onPressed: (){},
      color: Colors.deepPurple,
      child: Container(
        child: Text('Ingresar', style: TextStyle(color: Colors.white, fontSize: 18.0 ),), 
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0)
      )
    );
  }//_crearBoton

}//LoginPage