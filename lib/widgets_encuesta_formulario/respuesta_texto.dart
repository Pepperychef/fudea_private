
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fudea/utilities/tools.dart';

enum TipoInput { numerico, multi_linea, texto_simple }

class RespuestaTexto extends StatelessWidget {
  TipoInput input;

  String labelText;
  bool comentario;
  bool isLista;
  bool completada = false;
  String respuesta = '';
  ValueChanged<String> onSubmitted;
  VoidCallback? onTapInput;
  bool enabled = false;
  TextEditingController _controller = TextEditingController();

  RespuestaTexto(
      {required this.input,
      required this.completada,
      required this.respuesta,
      required this.onSubmitted,
      this.onTapInput,
      required this.enabled,
      this.labelText = "Ingrese Respuesta",
      this.isLista = false,
      this.comentario = false,});

  @override
  Widget build(BuildContext context) {
    _controller..text = respuesta;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      width: double.infinity,
      child: TextField(
        controller: _controller,
        onTap: onTapInput,
        enabled: enabled,
        //onChanged: onSubmitted,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide:  BorderSide(
                    color: Colors.lightGreen)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red)),
            labelStyle: const TextStyle(
                color: Colors.black),
            labelText: labelText),
        keyboardType: case2(input, {
          TipoInput.numerico: TextInputType.number,
          TipoInput.texto_simple: TextInputType.text,
          TipoInput.multi_linea: TextInputType.multiline,
        }),
        maxLines: input == TipoInput.multi_linea ? null : 1,
        inputFormatters: case2(input, {
          TipoInput.numerico: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
/*          TipoInput.texto_simple: null,
          TipoInput.multi_linea: null,*/
        }),
      ),
    );
  }
}
