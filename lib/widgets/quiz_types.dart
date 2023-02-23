import 'package:flutter/material.dart';
import 'package:fudea/widgets_encuesta_formulario/elemento_lista_seleccion_multiple.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion_multiple.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_texto.dart';
import 'package:toast/toast.dart';


class QuizTypes extends StatelessWidget {

  String tipo;
  bool permiteComentario;
  String tituloComentario;
  int idOdoo;
  bool validationRequired;
  String validationMinDate;
  String validationMaxDate;

  QuizTypes(
      {required this.tipo,
      required this.permiteComentario,
      required this.tituloComentario,
      required this.idOdoo,
      required this.validationRequired,
      required this.validationMaxDate,
      required this.validationMinDate});

  @override
  Widget build(BuildContext context) {

    switch (tipo) {
      case 'simple_choice':
        return prepareSimpleChoice(
            context);
      case 'multiple_choice':
        return prepareMultipleChoice(
            context);
      case 'text_box':
        return prepareTextBox(context);
      case 'char_box':
        return prepareCharBox(context);
      default:
        return Container();
    }
  }

  Widget prepareSimpleChoice(
      BuildContext context,) {
    return RespuestaSeleccion(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones:[]);
  }

  Widget prepareMultipleChoice(
      BuildContext context) {
    return RespuestaSeleccionMultiple(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones:[]);
  }

  Widget prepareTextBox(BuildContext context) {
    return RespuestaTexto(
      respuesta: '',
      completada: false,
      enabled: true,
      onTapInput: () => '',
      input: TipoInput.multi_linea,
      onSubmitted: (value) async {

      },
    );
  }

  Widget prepareCharBox(BuildContext context) {
    return RespuestaTexto(
      respuesta: '',
      completada: false,
      enabled: true,
      onTapInput: () => '',
      input: TipoInput.texto_simple,
      onSubmitted: (value) async {

      },
    );
  }



}
