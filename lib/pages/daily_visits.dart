import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/pages/summary.dart';

class DailyVisits extends StatelessWidget {
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
                              const Text('VISITAS DIARIAS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25
                                ),),

                            ],
                          ),),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: const Text('9 DE ENERO',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),),
                              margin: const EdgeInsets.only(left: 40),
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  gradient: LinearGradient(
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

                  Expanded(flex: 7, child: Container(
                      color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: List.generate(10, (index){

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Summary()));
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            elevation: 8,
                            shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              padding:const EdgeInsets.all(20),
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[
                                      Color.fromRGBO(0, 96, 157, 1),
                                      Color.fromRGBO(28, 59, 112, 1)
                                    ],
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text('BENEFICIARIO $index',style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20
                                  ),),
                                  const Text('direccion beneficiario',style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20
                                  ),),
                                  const Text('informacion',style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20
                                  ),),
                                  const Text('correo',style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20
                                  ),),
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
