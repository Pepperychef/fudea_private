
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'grabador.dart';

class RespuestaAudio extends StatelessWidget {
  String labelText;
  bool comentario;
  bool isLista;
  bool completada = false;
  VoidCallback onPressedGuardar;
  VoidCallback onPressedStart;
  VoidCallback onPressedBorrar;
  bool isRecording;
  bool enabled;
  double iconSize;

  RespuestaAudio(
      {required this.completada,
      required this.onPressedGuardar,
      required this.onPressedStart,
      required this.onPressedBorrar,
      required this.isRecording,
        required this.iconSize,
      this.enabled = false,
      this.labelText = "Ingrese Respuesta",
      this.isLista = false,
      this.comentario = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      width: double.infinity,
      child: Container(
        child: Grabador(
          onPressedStart: onPressedStart,
          onPressedGuardar: onPressedGuardar,
          isRecording: isRecording,
          onPressedBorrar: onPressedBorrar,
          enabled: enabled,
          iconSize: iconSize,
        ),
      ),
    );
  }
}
