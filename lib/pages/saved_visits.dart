import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:intl/intl.dart';

import '../data/entities/visit.dart';

class SavedVisits extends StatelessWidget{

  List<Visit> visits;
  int idUsuario;
  SavedVisits({required this.visits, required this.idUsuario});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendFilesToServer(visitas: visits, idUsuario: idUsuario);
        },
        backgroundColor: Color.fromRGBO(0, 95, 146, 1),
        child: const Icon(CupertinoIcons.cloud_upload),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Stack(
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
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height) / 8.5,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(
                                top:
                                (MediaQuery.of(context).size.height) / 16.5,
                                right: (MediaQuery.of(context).size.height) /
                                    26.5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize:
                                    (MediaQuery.of(context).size.height) /
                                        26.5,
                                    color: Colors.white,
                                    icon: const Icon(CupertinoIcons.back)),
                                Text(
                                  'RESUMEN VISITAS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      (MediaQuery.of(context).size.height) /
                                          35.5),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: (MediaQuery.of(context).size.height) /
                                      46.5),
                              child: Text(
                                DateFormat.MMMEd('es_US')
                                    .format(DateTime.now()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    (MediaQuery.of(context).size.height) /
                                        46.5),
                              ),
                              margin: EdgeInsets.only(
                                  left: (MediaQuery.of(context).size.height) /
                                      26.5),
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5),
                                      topLeft: Radius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5)),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color.fromRGBO(225, 191, 0, 1),
                                      Color.fromRGBO(240, 125, 0, 1)
                                    ],
                                  )),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: List.generate(visits.length, (index) {
                            return GestureDetector(
                              onTap: () async {

                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(
                                      (MediaQuery.of(context).size.height) /
                                          46.5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          Color.fromRGBO(0, 96, 157, 1),
                                          Color.fromRGBO(28, 59, 112, 1)
                                        ],
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        visits[index].nombreBeneficiario,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                                46.5),
                                      ),
                                      Text(
                                        visits[index].dirContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                                46.5),
                                      ),
                                      Text(
                                        visits[index].telefonoContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                                46.5),
                                      ),
                                      Text(
                                        visits[index].emailContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                                46.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}