import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/pages/evaluation_page.dart';
import 'package:fudea/providers/provider_summary.dart';
import 'package:provider/provider.dart';

import '../providers/provider_evaluacion.dart';

class Summary extends StatelessWidget {

  int localId;
  Visit visit;

  late ProviderEvaluacion _providerEvaluacion;
  late ProviderSummary _providerSummary;

  Summary({Key? key, required this.localId, required this.visit}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _providerEvaluacion = Provider.of<ProviderEvaluacion>(context);
    _providerSummary = Provider.of<ProviderSummary>(context);

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
                    height: MediaQuery.of(context).size.height / 5.7,

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

                  Expanded(
                      child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 120, left: 40, right: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: (MediaQuery.of(context).size.height) / 6.5,
                                width: (MediaQuery.of(context).size.height) / 6.5,
                                //square box; equal height and width so that it won't look like oval
                                child: GestureDetector(
                                  onTap: () {
                                    _providerSummary.getImage(context, visit.idProyecto, 'img_acta');

                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[
                                              Color.fromRGBO(0, 95, 146, 1),
                                              Color.fromRGBO(28, 59, 112, 1),
                                            ],
                                          )),
                                      child:  Icon(
                                        CupertinoIcons.camera,
                                        color: Colors.white,
                                        size: (MediaQuery.of(context).size.height) / 10.5,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height) / 6.5,
                              width: (MediaQuery.of(context).size.height) / 6.5,
                              //square box; equal height and width so that it won't look like oval
                              child: GestureDetector(

                                onTap: () {
                                  if(localId.isEven){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MultiProvider(
                                              child: EvaluationPage(),
                                                providers: [ChangeNotifierProvider.value(value: _providerEvaluacion)])));
                                  }

                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80),
                                    //set border radius more than 50% of height and width to make circle
                                  ),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors:localId.isEven? <Color>[
                                            const Color.fromRGBO(0, 95, 146, 1),
                                            const Color.fromRGBO(28, 59, 112, 1),
                                          ]: <Color>[
                                            Colors.grey,
                                            Colors.grey,
                                          ],
                                        )),
                                    child:  Icon(
                                      CupertinoIcons.doc_plaintext,
                                      color: Colors.white,
                                      size: (MediaQuery.of(context).size.height) / 10.5,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: (MediaQuery.of(context).size.height) / 6.5,
                                width: (MediaQuery.of(context).size.height) / 6.5,
                                //square box; equal height and width so that it won't look like oval
                                child: GestureDetector(
                                  onTap: () {
                                    _providerSummary.getImage(context, visit.idProyecto, 'img_evidencia');
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[
                                              Color.fromRGBO(240, 125, 0, 1),
                                              Color.fromRGBO(225, 191, 0, 1),
                                            ],
                                          )),
                                      child:  Icon(
                                        CupertinoIcons.shield_lefthalf_fill,
                                        color: Colors.white,
                                        size: (MediaQuery.of(context).size.height) / 10.5,
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                                height: (MediaQuery.of(context).size.height) / 6.5,
                                width: (MediaQuery.of(context).size.height) / 6.5,
                                //square box; equal height and width so that it won't look like oval
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[
                                              Color.fromRGBO(240, 125, 0, 1),
                                              Color.fromRGBO(225, 191, 0, 1),
                                            ],
                                          )),
                                      child:  Icon(
                                        CupertinoIcons.floppy_disk,
                                        color: Colors.white,
                                        size: (MediaQuery.of(context).size.height) / 10.5,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  )),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height) /10.5,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height) / 16.5,
                        right:
                        (MediaQuery.of(context).size.width) / 9.5),
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
                          'RESUMEN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              (MediaQuery.of(context).size.height) /
                                  36.5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          'NOMBRE BENEFICIARIO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              (MediaQuery.of(context).size.height) /
                                  56.5),
                        ),
                        Text(
                          'RESUMEN INFORMACION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              (MediaQuery.of(context).size.height) /
                                  36.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],

          ),

        ),
      ),
    );
  }
}
