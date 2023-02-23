import 'package:flutter/material.dart';


class RespuestaSeleccion extends StatelessWidget {
  bool? completada = false;
  List? opcionesActivas = [];
  bool? permiteComentario = false;

  String? tituloComentario = '';

  List<Widget>? opciones;

  RespuestaSeleccion(
      {this.completada,
      this.opcionesActivas,
      this.permiteComentario,
      this.tituloComentario, this.opciones});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: opciones!);
  }




}
