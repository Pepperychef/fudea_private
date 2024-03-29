import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/pages/daily_visits.dart';
import 'package:fudea/pages/saved_visits.dart';
import 'package:fudea/providers/provider_visitas.dart';
import 'package:fudea/utilities/conexiones.dart';
import 'package:fudea/utilities/constantes.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:fudea/widgets/home_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../widgets/contenido_boton_Login.dart';

class Home extends StatelessWidget {
  int userID;
  String userName;
  String user;
  bool online;

  Constantes constantes = Constantes();

  Home(
      {required this.user,
      required this.userID,
      required this.userName,
      required this.online});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
                  Expanded(child: Container(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.width) / 4.5,
                      bottom: (MediaQuery.of(context).size.width) / 12.5,
                      left: (MediaQuery.of(context).size.width) / 12.5,
                      right: (MediaQuery.of(context).size.width) / 12.5,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          '$userName',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  (MediaQuery.of(context).size.height) / 26.5),
                        ),
                        Text('$user',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: (MediaQuery.of(context).size.height) /
                                    46.5)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width) / 15.5),
                    height: (MediaQuery.of(context).size.height) / 6.5,
                    width: (MediaQuery.of(context).size.width) / 1.5,
                    child: HomeButtons(
                        whiteBackground: false,
                        child: contenidoBoton(
                            false,
                            'Consultar Visitas Diarias',
                            false,
                            (MediaQuery.of(context).size.height) / 36.5),
                        onPressed: () async {
                          online = await Conexiones.checkConection();
                          if (online) {
                            var response = await http.get(
                              Uri.parse(constantes.url),
                              headers: {'User-Id': '$userID'},
                            );

                            Map<String, dynamic> list =
                                json.decode(response.body);

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // The loading indicator
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Some text
                                    Text('Cargando...')
                                  ],
                                ),
                              ),
                            );

                            handleLocationPermission(context).then((value) {
                              if (value) {
                                saveData(list: list, context: context)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  MultiProvider(
                                                      child: DailyVisits(),
                                                      providers: [
                                                        ChangeNotifierProvider.value(
                                                            value:
                                                                ProviderVisitas(
                                                                    visits:
                                                                        value))
                                                      ])));
                                });
                              }
                            });
                          }else{
                            loadData().then((value){
                              //Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          MultiProvider(
                                              child: DailyVisits(),
                                              providers: [
                                                ChangeNotifierProvider.value(
                                                    value:
                                                    ProviderVisitas(
                                                        visits:
                                                        value))
                                              ])));
                            });

                          }
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height) / 5),
                    width: (MediaQuery.of(context).size.width) / 1.5,
                    height: (MediaQuery.of(context).size.height) / 6.5,
                    child: HomeButtons(
                        whiteBackground: true,
                        child: contenidoBoton(false, 'Enviar Progreso del Dia',
                            true, (MediaQuery.of(context).size.height) / 36.5),
                        onPressed: () {
                          fetchSavedVisits().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SavedVisits(
                                          visits: value,
                                          idUsuario: userID,
                                        )));
                          });
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
