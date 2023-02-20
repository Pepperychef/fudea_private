
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Summary extends StatelessWidget{
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
                    height: MediaQuery.of(context).size.height / 4.5,
                    child: Column(children: [
                      Container(
                        height: 90,
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 60, right: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                iconSize: 35,
                                color: Colors.white,
                                icon: const Icon(CupertinoIcons.back)),
                            const Text('RESUMEN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                              ),),

                          ],
                        ),),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: const [
                             Text('NOMBRE BENEFICIARIO',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),),
                             Text('RESUMEN INFORMACION',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                              ),),
                          ],
                        ),
                      ),
                    ],),
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
                  Expanded(child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 120, left: 40, right: 40),
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
                              height: 150, width:150,
                              //square box; equal height and width so that it won't look like oval
                              child:Card(

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
                                  )
                                  ),

                                  child: const Icon(
                                      CupertinoIcons.device_phone_portrait,
                                    color: Colors.white,
                                    size: 90,
                                  ),

                                ),
                              )
                          ),
                          SizedBox(
                              height: 150, width:150,
                              //square box; equal height and width so that it won't look like oval
                              child:Card(
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
                                      )
                                  ),

                                  child: const Icon(
                                    CupertinoIcons.doc_plaintext,
                                    color: Colors.white,
                                    size: 90,
                                  ),

                                ),
                              )
                          )
                        ],),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 150, width:150,
                                //square box; equal height and width so that it won't look like oval
                                child:Card(
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
                                        )
                                    ),

                                    child: const Icon(
                                      CupertinoIcons.shield_lefthalf_fill,
                                      color: Colors.white,
                                      size: 90,
                                    ),

                                  ),
                                )
                            ),
                            SizedBox(
                                height: 150, width:150,
                                //square box; equal height and width so that it won't look like oval
                                child:Card(
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
                                        )
                                    ),

                                    child: const Icon(
                                      CupertinoIcons.home,
                                      color: Colors.white,
                                      size: 90,
                                    ),

                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                  ,
                ],
              ),
            ],

          ),

        ),
      ),
    );
  }


}