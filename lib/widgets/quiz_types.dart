import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/widgets/gradient_icon.dart';
import 'package:fudea/widgets_encuesta_formulario/elemento_lista_seleccion_multiple.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_nota.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion_binaria.dart';
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
      case 'bool_choice':
        return prepareBoolChoice(context);
      case 'score':
        return prepareScore(context);
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
        opciones:List.generate(2, (index){
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: GradientIcon(
                              icon: true
                                  ? CupertinoIcons.circle_filled
                                  : CupertinoIcons.circle,
                              size: (MediaQuery.of(context).size.height) / 40,
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color.fromRGBO(240, 125, 0, 1),
                                  Color.fromRGBO(225, 191, 0, 1)
                                ],
                              ),


                            )
,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'OPTION $index',
                              style:  TextStyle(
                              fontSize: (MediaQuery.of(context).size.height) / 60
                      ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget prepareMultipleChoice(
      BuildContext context) {
    return RespuestaSeleccionMultiple(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones:List.generate(3, (index){
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: GradientIcon(
                              icon: true
                                  ? CupertinoIcons.circle_filled
                                  : CupertinoIcons.circle,
                              size: (MediaQuery.of(context).size.height) / 40,
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color.fromRGBO(240, 125, 0, 1),
                                  Color.fromRGBO(225, 191, 0, 1)
                                ],
                              ),


                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'OPTION $index',
                            style: TextStyle(fontSize: (MediaQuery.of(context).size.height) / 60),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget prepareTextBox(BuildContext context) {
    return RespuestaTexto(
      respuesta: '',
      completada: false,
      enabled: true,
      onTapInput: () => '',
      input: TipoInput.multi_linea,
      tituloComentario: tituloComentario,
      onSubmitted: (value) async {

      },
    );
  }

  Widget prepareBoolChoice(BuildContext context){
    return RespuestaSeleccionBinaria(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones:List.generate(2, (index){
          return Container(
            width: MediaQuery.of(context).size.width/2,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[


                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(index == 0 ?
                          'YES': 'NO',
                            style: TextStyle(fontSize: (MediaQuery.of(context).size.height) / 60),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: GradientIcon(
                              icon: true
                                  ? CupertinoIcons.circle_filled
                                  : CupertinoIcons.circle,
                              size: (MediaQuery.of(context).size.height) / 40,
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color.fromRGBO(240, 125, 0, 1),
                                  Color.fromRGBO(225, 191, 0, 1)
                                ],
                              ),


                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        })
    );

  }

 Widget prepareScore(BuildContext context){
    return RespuestaNota(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones:List.generate(5, (index){
          return Container(
            //margin: EdgeInsets.only(right: 20, left: 20),
            width: MediaQuery.of(context).size.width/10,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: (){},
                child: Container(
                  child:GradientIcon(
                    icon: true
                        ? CupertinoIcons.circle_filled
                        : CupertinoIcons.circle,
                    size: (MediaQuery.of(context).size.height) / 40,
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color.fromRGBO(240, 125, 0, 1),
                        Color.fromRGBO(225, 191, 0, 1)
                      ],
                    ),


                  ),
                ),
              ),
            ),
          );
        })

    );
 }



}
