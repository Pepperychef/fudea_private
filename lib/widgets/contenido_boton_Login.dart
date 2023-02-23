import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget contenidoBoton(bool _cargando, String texto, bool offButton, double fontSize){


  if(_cargando){
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }else{
    return Text("$texto",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "RobotoMedium",
            fontSize: fontSize,

            color: offButton ? Colors.white:Colors.blueGrey));
  }

}