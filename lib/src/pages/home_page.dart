import 'package:flutter/material.dart';
import 'package:validaciones_crud/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page xD'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Tu email,es : ${bloc.email} '),
          Divider(),
          Text('password: ${bloc.password} '),
        ],
      ),
    );
  }
}