import 'package:flutter/material.dart';


class RespuestaNota extends StatelessWidget {
  bool? completada = false;
  List? opcionesActivas = [];
  bool? permiteComentario = false;

  String? tituloComentario = '';

  List<Widget>? opciones;

  RespuestaNota(
      {this.completada,
      this.opcionesActivas,
      this.permiteComentario,
      this.tituloComentario, this.opciones});

  @override
  Widget build(BuildContext context) {


    return Column(
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
          height: MediaQuery.of(context).size.height/18,
          child:ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: opciones!) ,
        )

      ],
    );
  }




}
