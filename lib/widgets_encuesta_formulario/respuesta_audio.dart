
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/peppery_audio_recorder.dart';
import 'grabador.dart';

class RespuestaAudio extends StatelessWidget {
  String labelText;
  bool comentario;
  bool isLista;
  bool completada = false;
  VoidCallback onPressedGuardar;
  VoidCallback onPressedStart;
  VoidCallback onPressedBorrar;
  bool isRecording = false;
  Recording recording;
  String? savedPath;
  int position = 0;
  int duration = 0;
  PlayerState playerState;
  VoidCallback play;
  VoidCallback stop;
  bool enabled;
  String textDuration;

  RespuestaAudio(
      {required this.completada,
      required this.onPressedGuardar,
      required this.onPressedStart,
      required this.onPressedBorrar,
      required this.isRecording,
      required this.recording,
      required this.position,
      required this.duration,
      required this.playerState,
      required this.play,
      required this.stop,
      this.enabled = false,
      this.savedPath,
      this.labelText = "Ingrese Respuesta",
      this.isLista = false,
      this.comentario = false,
      required this.textDuration,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      width: double.infinity,
      child: Container(
        child: Grabador(
          savedPath: savedPath,
          onPressedStart: onPressedStart,
          onPressedGuardar: onPressedGuardar,
          isRecording: isRecording,
          recording: recording,
          playerState: playerState,
          stop: stop,
          duration: duration,
          onPressedBorrar: onPressedBorrar,
          play: play,
          enabled: enabled,
          position: position,
          textDuration: textDuration,
        ),
      ),
    );
  }
}
