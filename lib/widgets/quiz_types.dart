import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/data/entities/response.dart';
import 'package:fudea/providers/provider_evaluacion.dart';
import 'package:fudea/widgets/gradient_icon.dart';
import 'package:fudea/widgets_encuesta_formulario/elemento_lista_seleccion_multiple.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_nota.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion_binaria.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_seleccion_multiple.dart';
import 'package:fudea/widgets_encuesta_formulario/respuesta_texto.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../data/entities/option.dart';

class QuizTypes extends StatelessWidget {
  String tipo;
  bool permiteComentario;
  String tituloComentario;
  int index;
  bool validationRequired;
  String validationMinDate;
  String validationMaxDate;
  int idProyecto;
  int idEvaluation;

  late ProviderEvaluacion _provider;

  QuizTypes(
      {required this.tipo,
      required this.permiteComentario,
      required this.tituloComentario,
      required this.index,
      required this.validationRequired,
      required this.validationMaxDate,
        required this.idProyecto,

      required this.validationMinDate, this.idEvaluation = 0});

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ProviderEvaluacion>(context);

    switch (tipo) {
      case 'opcion':
        return prepareSimpleChoice(context, idProyecto);
      case 'seleccion':
        return prepareMultipleChoice(context, idProyecto);
      case 'texto':
        return prepareTextBox(context, idProyecto);
      case 'bool':
        return prepareBoolChoice(context, idProyecto, idEvaluation);
      case 'nota':
        return prepareScore(context, idProyecto);
      default:
        return Container();
    }
  }

  Widget prepareSimpleChoice(
    BuildContext context,
      int idProyecto
  ) {
    List<Option> _listOptions = _provider.listOptions[index].values.toList();
    List<Response> _response = _provider.listResponses[index];
    return RespuestaSeleccion(
        completada: false,
        opcionesActivas: _provider.listResponses[index],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones: List.generate(_listOptions.length, (_index) {

          bool existe = false;

          for (Response _resp in _response) {
            if (_resp.idOption == _listOptions[_index].idOption) {
              existe = true;
            }
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: () {
                  /*if (_response.isNotEmpty) {
                    _provider.listResponses[index] = [];
                    _provider.listResponses[index] = [
                      Response(
                          idProyecto: idProyecto,
                          strOption: '',
                          idOption: _listOptions[index].idOption,
                          idEvaluation: _listOptions[index].idEvaluation)
                    ];
                  } else {
                    _provider.listResponses.add([
                      Response(
                          idProyecto: idProyecto,
                          strOption: '',
                          idOption: _listOptions[index].idOption,
                          idEvaluation: _listOptions[index].idEvaluation)
                    ]);
                  }

                  _provider.notifyListeners();*/

                  Response _responseTemp = Response(
                      idProyecto: idProyecto,
                      strOption: '',
                      idOption: _listOptions[_index].idOption,
                      idEvaluation: _listOptions[_index].idEvaluation);



                  _response = [_responseTemp];

                  _provider.listResponses[index] = _response;

                  _provider.notifyListeners();
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: GradientIcon(
                              icon: existe
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
                            _listOptions[_index].strOption,
                            style: TextStyle(
                                fontSize:
                                    (MediaQuery.of(context).size.height) / 60),
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

  Widget prepareMultipleChoice(BuildContext context, int idProyecto) {
    List<Option> _listOptions = _provider.listOptions[index].values.toList();
    List<Response> _response = _provider.listResponses[index];
    return RespuestaSeleccionMultiple(
        completada: false,
        opcionesActivas: [],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones: List.generate(_listOptions.length, (index) {
          bool existe = false;

          for (Response _resp in _response) {
            if (_resp.idOption == _listOptions[index].idOption) {
              existe = true;
            }
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: () {
                  List<Response> _tmp = _response;

                  Response _responseTemp = Response(
                      idProyecto: idProyecto,
                      strOption: '',
                      idOption: _listOptions[index].idOption,
                      idEvaluation: _listOptions[index].idEvaluation);

                  if (_tmp.isNotEmpty) {
                    bool _exist = false;
                    int _count = 0;
                    int _position = 0;

                    for (Response _resp in _response) {
                      if (_resp.idOption == _listOptions[index].idOption) {
                        _exist = true;
                        _position = _count;
                      }
                      _count++;
                    }
                    if (_exist) {
                      _tmp.removeAt(_position);
                    } else {
                      _tmp.add(_responseTemp);
                    }
                  } else {
                    _tmp.add(_responseTemp);
                  }

                  _response = _tmp;

                  _provider.notifyListeners();
                },
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
                              icon: existe
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
                            _listOptions[index].strOption,
                            style: TextStyle(
                                fontSize:
                                    (MediaQuery.of(context).size.height) / 60),
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

  Widget prepareTextBox(BuildContext context, int idProyecto) {
    List<Option> _listOptions = _provider.listOptions[index].values.toList();
    List<Response> _response = _provider.listResponses[index];
    return RespuestaTexto(
      respuesta: _response.isNotEmpty ? _response[0].strOption : '',
      completada: false,
      enabled: true,
      onTapInput: () => '',
      input: TipoInput.multi_linea,
      tituloComentario: tituloComentario,
      onSubmitted: (value) async {
        if (_response.isNotEmpty) {

          _response[0] = Response(
              strOption: value,
              idProyecto: idProyecto,
              idOption: 0,
              idEvaluation: _provider.listEvaluation[index].idPregunta);

        } else {
          _response.add(
            Response(
                strOption: value,
                idProyecto: idProyecto,
                idOption: 0,
                idEvaluation: _provider.listEvaluation[index].idPregunta)
          );
        }

        //_provider.notifyListeners();
      },
    );
  }

  Widget prepareBoolChoice(BuildContext context, int idProyecto, int idEvaluation) {
    List<Response> _response = _provider.listResponses[index];


    return RespuestaSeleccionBinaria(
        completada: false,
        opcionesActivas: _provider.listResponses[index],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones: List.generate(2, (_index) {

          bool existe = false;

          for (Response _resp in _response) {
            if (_resp.idOption == _index) {
              existe = true;
            }
          }

          return Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: () {
                  Response _responseTemp = Response(
                      idProyecto: idProyecto,
                      strOption: '',
                      idOption: _index,
                      idEvaluation: idEvaluation);

                  _response = [_responseTemp];

                  _provider.listResponses[index] = _response;

                  _provider.notifyListeners();
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _index.isEven? 'No': 'Si',
                            style: TextStyle(
                                fontSize:
                                    (MediaQuery.of(context).size.height) / 60),
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
                              icon: existe
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
        }));
  }

  Widget prepareScore(BuildContext context, idProyecto) {
    List<Response> _response = _provider.listResponses[index];


    return RespuestaNota(
        completada: false,
        opcionesActivas: _provider.listResponses[index],
        permiteComentario: permiteComentario,
        tituloComentario: tituloComentario,
        opciones: List.generate(5, (_index) {
          bool existe = false;

          for (Response _resp in _response) {
            if (_resp.idOption >= _index) {
              existe = true;
            }
          }

          return Container(
            //margin: EdgeInsets.only(right: 20, left: 20),
            width: MediaQuery.of(context).size.width / 10,
            child: Card(
              elevation: 0,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: () {

                  Response _responseTemp = Response(
                      idProyecto: idProyecto,
                      strOption: '',
                      idOption: _index,
                      idEvaluation: idEvaluation);

                  _response = [_responseTemp];

                  _provider.listResponses[index] = _response;

                  _provider.notifyListeners();


                },
                child: Container(
                  child: GradientIcon(
                    icon: existe ?

                        CupertinoIcons.circle_filled
                        : CupertinoIcons.circle ,
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
        }));
  }
}
