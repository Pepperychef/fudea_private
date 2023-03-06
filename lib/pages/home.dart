import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/pages/daily_visits.dart';
import 'package:fudea/widgets/home_buttons.dart';
import 'package:http/http.dart' as http;

import '../widgets/contenido_boton_Login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Column(
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
                    height: MediaQuery.of(context).size.height / 2.4,
                    // color: const Color.fromRGBO(0, 95, 146, 1),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Image.asset(
                      'assets/img/curva_colores.png',

                      fit: BoxFit.cover,
                      //height: 120.0,
                    ),
                  ),
                  Expanded(child: Container(

                      color: Colors.white))
                  ,
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:  EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width) / 4.5,
                        bottom: (MediaQuery.of(context).size.width) / 12.5),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children:  [
                        Text(
                          'YOUR NAME',
                          style: TextStyle(color: Colors.white, fontSize: (MediaQuery.of(context).size.height) / 26.5),
                        ),
                        Text('correo@email.com',
                            style:
                            TextStyle(color: Colors.white, fontSize: (MediaQuery.of(context).size.height) / 46.5)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: (MediaQuery.of(context).size.width) / 15.5),
                    height: (MediaQuery.of(context).size.height) / 6.5,
                    width: (MediaQuery.of(context).size.width) / 1.5,
                    child: HomeButtons(
                        whiteBackground: false,
                        child: contenidoBoton(
                          false,
                          'Visitar Consultas Diarias',
                          false,
                            (MediaQuery.of(context).size.height) / 36.5
                        ),
                        onPressed: () async {
                          String url = 'http://vps-2872295-x.dattaweb.com:8069/operaciones/app/visitas/1';

                          var response = await http.get(
                            Uri.parse(url),
                            headers: {"Accept": 'application/json'},
                          );

                          print('w');



                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DailyVisits()));
                        }),
                  ),

                  Container(
                    margin:  EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 5),
                    width: (MediaQuery.of(context).size.width) / 1.5,
                    height: (MediaQuery.of(context).size.height) / 6.5,
                    child: HomeButtons(
                        whiteBackground: true,
                        child: contenidoBoton(
                          false,
                          'Enviar Progreso del Dia',
                          true,
                            (MediaQuery.of(context).size.height) / 36.5
                        ),
                        onPressed: () {
                          //Navigator.push(context, route)
                        }),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
