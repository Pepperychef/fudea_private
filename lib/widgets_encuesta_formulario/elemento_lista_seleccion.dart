import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementoListaSeleccion extends StatelessWidget {
  bool completada = false;
  List lineasRespuesta = [];
  dynamic opcion;
  GestureTapCallback onTap;

  ElementoListaSeleccion(
      {required this.completada,
      required this.opcion,
      required this.lineasRespuesta,
      required this.onTap,});

  @override
  Widget build(BuildContext context) {
    bool checked = false;
    if (lineasRespuesta != null && lineasRespuesta.isNotEmpty) {
      if (lineasRespuesta
          .map((e) => e.idOpcion)
          .toList()
          .contains(opcion.idOdoo)) {
        checked = true;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        color: Colors.lightGreen,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.red, BlendMode.srcATop),
                          child: Icon(checked
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${opcion.descripcion}',
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
