import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/providers/provider_grabador_encuesta.dart';
import 'package:fudea/widgets/quiz_types.dart';
import 'package:provider/provider.dart';

import '../data/entities/evaluation.dart';
import '../providers/provider_evaluacion.dart';
import '../widgets_encuesta_formulario/respuesta_audio.dart';

class EvaluationPage extends StatelessWidget{

  late ProviderEvaluacion _provider;
  late ProviderGrabadorEncuesta _providerGrabador;

  @override
  Widget build(BuildContext _context) {

    _provider = Provider.of<ProviderEvaluacion>(_context);
    _providerGrabador = Provider.of<ProviderGrabadorEncuesta>(_context);

    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color.fromRGBO(28, 59, 112, 1),
                                      Color.fromRGBO(0, 95, 146, 1)
                                    ],
                                  )),
                            ),
                            Container(

                              alignment: Alignment.topCenter,
                              margin:  EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 20.5, right: (MediaQuery.of(context).size.width) / 10.5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  },
                                      iconSize: (MediaQuery.of(context).size.height) /
                                          26.5,
                                      color: Colors.white,
                                      icon: const Icon(CupertinoIcons.back)),
                                  Text('EVALUACION',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: (MediaQuery.of(context).size.height) /
                                              36.5)
                                  ),

                                ],
                              ),),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                alignment: Alignment.center,
                                child:  RespuestaAudio(
                                  completada: false,
                                  onPressedGuardar: () => _providerGrabador.saveRecording(),
                                  onPressedStart: () {
                                    _providerGrabador.startRecording(context);
                                  },
                                  enabled: true,
                                  savedPath:  _providerGrabador.valueRespuesta,
                                  onPressedBorrar: () => _providerGrabador.deleteRecording(),
                                  isRecording: _providerGrabador.isRecording,
                                  recording: _providerGrabador.recording,
                                  playerState: _providerGrabador.playerState,
                                  stop: () => _providerGrabador.stop(),
                                  duration: _providerGrabador.duration,
                                  position: _providerGrabador.position,
                                  play: () => _providerGrabador.play(),
                                  textDuration: _providerGrabador.textDuration,
                                ),

                                height: MediaQuery.of(context).size.height / 10,
                                width: MediaQuery.of(context).size.width / 2.8,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular((MediaQuery.of(context).size.height) / 46.5),
                                        topLeft: Radius.circular((MediaQuery.of(context).size.height) / 46.5)),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Color.fromRGBO(225, 191, 0, 1),
                                        Color.fromRGBO(240, 125, 0, 1)
                                      ],
                                    )),
                              ),
                            )
                          ],
                        )),

                    Expanded(flex: 8,
                        child: Container(
                          color: Colors.white,
                          child: ListView(

                            shrinkWrap: true,
                            children: List.generate(_provider.listEvaluation.length, (index){

                              return MultiProvider(
                                  child: QuizTypes(
                                      idProyecto: _provider.listEvaluation[index].idProyecto,
                                      tipo: _provider.listEvaluation[index].tipo,
                                      permiteComentario: false,
                                      tituloComentario: _provider.listEvaluation[index].textoPregunta,
                                      index: index,
                                      validationRequired: false,
                                      validationMaxDate: '',
                                      validationMinDate: ''
                                  ),
                                  providers:[
                                    ChangeNotifierProvider.value(value: _provider)

                                  ]);


                            }),
                          ),
                        ))

                  ],
                )
              ],

            ),
          ),
        ),
      ),
    );
  }


}