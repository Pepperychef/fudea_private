import 'package:flutter/material.dart';
import 'package:fudea/pages/home.dart';
import 'package:fudea/widgets/login_content.dart';

import '../widgets/contenido_boton_Login.dart';
import '../widgets/signin_button.dart';

class LoginBasic extends StatelessWidget {
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
                    flex: 4,
                    child: Container(
                      color: const Color.fromRGBO(0, 95, 146, 1),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/img/wave.png',
                        width: MediaQuery.of(context).size.width,
                        //height: 120.0,
                      ),
                    ),
                  ),
                  Expanded(flex: 5, child: Container(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children:  [
                         Expanded(flex: 3,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: const Text('BIENVENIDO',
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: 30
                              ),),
                          ),
                        ),
                        Expanded(flex: 7,
                            child: Image.asset(
                          'assets/img/logo.png',
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          //height: 120.0,
                        )),


                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.topCenter,

                    ),
                  ),
                  Expanded(flex: 5, child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.only(right: 65.0, left: 15.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              hintText: "Username or E-Mail",
                              prefixIcon: Icon(
                                Icons.mail,
                              )),
                          onSubmitted: (value) {

                          },
                          onChanged: (value) {

                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder:const  UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)),
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                            ),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                              },
                              child: const Icon(
                                true ? Icons.visibility : Icons.visibility_off,
                                semanticLabel: true
                                    ? 'ver contraseña'
                                    : 'ocultar ontraseña',
                              ),
                            ),
                          ),
                          onSubmitted: (value) {
                          },
                          onChanged: (value) {
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: (MediaQuery.of(context).size.width) / 1.5,
                        child: SigninButton(whiteBackground: true,
                            child: contenidoBoton(false, 'Log In', true,),
                            onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  Home()));

                            }),
                      )

                    ],
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
