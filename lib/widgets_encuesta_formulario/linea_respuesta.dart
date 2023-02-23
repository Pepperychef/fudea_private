import 'package:flutter/material.dart';

import '../utilities/tools.dart';

class CardLineaRespuesta extends StatelessWidget {
  BuildContext context;
  Function function;
  String encuentaFecha;
  String encuestaTitulo;
  bool incluirHora;
  String state;
  Color colorState;

  CardLineaRespuesta(
      {required this.context,
      required this.function,
      required this.encuentaFecha,
      required this.encuestaTitulo,
      required this.state,
      required this.colorState,
      this.incluirHora = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
      width: MediaQuery.of(context).size.width,
      height: 90,
    );
  }

  Widget body(BuildContext context) {
    return Card(
      color: Colors.red,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
          onTap: function as void Function()?,
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  infoZone(context, encuentaFecha, encuestaTitulo)
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    padding: EdgeInsets.only(top: 10.0, right: 15.0),
                    child: Text(
                      state,
                      style: TextStyle(
                          color: colorState, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          )),
    );
  }

  Widget infoZone(
      BuildContext context, String encuentaFecha, String encuestaTitulo) {
    DateTime realDate = string2DatetimeWithOutConvert(encuentaFecha);
    return Expanded(
      flex: 7,
      child: Container(
        margin: EdgeInsets.all(2.5),
        child: Row(children: <Widget>[
          Expanded(
              child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 40.0),
                      child: Text(
                        encuestaTitulo,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      incluirHora
                          ? dateTime2String(realDate)
                          : dateTime2StringWithHour(realDate),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    )),
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
