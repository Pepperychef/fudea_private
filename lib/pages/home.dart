import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/pages/daily_visits.dart';
import 'package:fudea/widgets/home_buttons.dart';

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
                    height: MediaQuery.of(context).size.height / 2.5,
                    // color: const Color.fromRGBO(0, 95, 146, 1),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 7,
                    child: Image.asset(
                      'assets/img/curva_colores.png',

                      fit: BoxFit.cover,
                      //height: 120.0,
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      color: Colors.white),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(top: 120, bottom: 20),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: const [
                          Text(
                            'YOUR NAME',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          Text('correo@email.com',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      width: (MediaQuery.of(context).size.width) / 1.5,
                      child: HomeButtons(
                          whiteBackground: false,
                          child: contenidoBoton(
                            false,
                            'Visitar Consultas Diarias',
                            false,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DailyVisits()));
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      width: (MediaQuery.of(context).size.width) / 1.5,
                      child: HomeButtons(
                          whiteBackground: true,
                          child: contenidoBoton(
                            false,
                            'Enviar Progreso del Dia',
                            true,
                          ),
                          onPressed: () {
                            //Navigator.push(context, route)
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.topCenter,
                    ),
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
