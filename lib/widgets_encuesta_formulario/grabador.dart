import 'dart:math';
import 'package:flutter/material.dart';

import '../utilities/peppery_audio_recorder.dart';

enum PlayerState { stopped, playing, paused }

class Grabador extends StatelessWidget {
  VoidCallback onPressedGuardar;
  VoidCallback onPressedStart;
  VoidCallback onPressedBorrar;
  VoidCallback play;
  VoidCallback stop;
  bool isRecording = false;
  Recording recording;
  Random random = Random();
  String? savedPath;
  int position = 0;
  int duration = 0;
  PlayerState playerState;
  bool enabled = false;
  String textDuration;

  Grabador(
      {required this.onPressedGuardar,
      required this.onPressedStart,
      required this.onPressedBorrar,
      required this.isRecording,
      required this.recording,
      required this.position,
      required this.duration,
      required this.playerState,
      required this.play,
      required this.stop,
      required this.enabled,
      this.savedPath,
      required this.textDuration,});

  @override
  Widget build(BuildContext context) {

    return  Center(
      child:  Padding(
        padding:  const EdgeInsets.all(2.0),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            recording.path == '' ||
                recording.path == null ||
                isRecording && enabled
                ? IconButton(
              onPressed:
              isRecording ? onPressedGuardar : onPressedStart,
              iconSize: 40.0,
              icon: Icon(isRecording ? Icons.save : Icons.mic),

            )
                : Container(),
            recording.path == '' || recording.path == null || isRecording
                ? Container()
                : IconButton(
              onPressed:
              playerState == PlayerState.playing || isRecording
                  ? null
                  : play,
              iconSize: 60.0,
              icon: Icon(Icons.play_arrow),
            ),
            recording.path == '' || recording.path == null || isRecording
                ? Container()
                : IconButton(
              onPressed: playerState == PlayerState.playing ||
                  playerState == PlayerState.paused
                  ? stop
                  : null,
              iconSize: 60.0,
              icon: Icon(Icons.stop),
            ),
            recording.path == '' || recording.path == null || isRecording
                ? Container()
                : IconButton(
              onPressed: enabled
                  ? playerState == PlayerState.playing ||
                  isRecording
                  ? null
                  : onPressedBorrar
                  : null,
              iconSize: 60.0,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
