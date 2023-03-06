
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
  String? tituloComentario = '';
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
        this.tituloComentario,
      this.comentario = false,});

  @override
  Widget build(BuildContext context) {
    _controller..text = respuesta;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(bottom: 10, left: 20),
            child: Text(
              tituloComentario!,
              style: TextStyle(
                  color: const Color.fromRGBO(0, 96, 157, 1),
                  fontSize: (MediaQuery.of(context).size.height) / 36.5),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 70,
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              decoration:const  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color.fromRGBO(240, 125, 0, 1),
                      Color.fromRGBO(225, 191, 0, 1)
                    ],
                  )),
            ),
          ),
          Container(
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
                          color: Color.fromRGBO(240, 125, 0, 1))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(225, 191, 0, 1))),
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
          )
        ],
      ),
    );
  }
}
