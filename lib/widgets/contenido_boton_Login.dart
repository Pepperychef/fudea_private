import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget contenidoBoton(bool _cargando, String texto, bool offButton){

  if(_cargando){
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }else{
    return Text("$texto",
        style: TextStyle(
            fontFamily: "RobotoMedium",
            fontSize: 16.0,
            color: offButton ? Colors.white:Colors.black));
  }

}