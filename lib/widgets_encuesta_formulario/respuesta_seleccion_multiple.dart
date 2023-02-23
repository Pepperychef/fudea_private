import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RespuestaSeleccionMultiple extends StatelessWidget {
  bool? completada = false;
  List? opcionesActivas = [];
  bool? permiteComentario = false;
  String? tituloComentario = '';
  List<Widget>? opciones;

  RespuestaSeleccionMultiple(
      {this.completada,
      this.opcionesActivas,
      this.permiteComentario,
      this.tituloComentario,
      this.opciones});

  @override
  Widget build(BuildContext context) {
    return new ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: opciones!);
  }
}
