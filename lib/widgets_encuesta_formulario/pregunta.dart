import 'package:flutter/material.dart';

class PreguntaWidget extends StatelessWidget {
  final String? questionText;
  bool? multiple;

  PreguntaWidget({this.questionText, this.multiple});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Text(
            questionText!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),

        multiple!?
        Text(
          'Por favor, seleccione todas las respuestas pertinentes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.center,
        ):Container(height: 0.0, width: 0.0,)
      ],
    );
  }
}
