import 'dart:math';
import 'package:flutter/material.dart';

enum PlayerState { stopped, playing, paused }

class Grabador extends StatelessWidget {
  VoidCallback onPressedGuardar;
  VoidCallback onPressedStart;
  VoidCallback onPressedBorrar;
  bool isRecording;
  bool enabled = false;
  double iconSize;


  Grabador(
      {required this.onPressedGuardar,
      required this.onPressedStart,
      required this.onPressedBorrar,
      required this.isRecording,
      required this.enabled,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {

    return  Center(
      child:  Padding(
        padding:  const EdgeInsets.all(2.0),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed:
              isRecording ? onPressedGuardar : onPressedStart,
              iconSize: iconSize,
              icon: Icon(isRecording ? Icons.save : Icons.mic, color: Colors.white,),

            ),

          ],
        ),
      ),
    );
  }
}
