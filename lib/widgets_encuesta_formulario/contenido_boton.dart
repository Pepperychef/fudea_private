import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget contenidoBoton( bool _cargando, String _label){

  if(_cargando){
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
    );
  }else{
    return Text(_label,
        style: TextStyle(
            fontFamily: "RobotoMedium",
            fontSize: 16.0,
            color: Colors.lightGreen));
  }

}