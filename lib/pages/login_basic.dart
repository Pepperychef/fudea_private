import 'package:flutter/material.dart';
import 'package:fudea/pages/home.dart';
import 'package:fudea/widgets/login_content.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../providers/provider_login.dart';
import '../widgets/contenido_boton_Login.dart';
import '../widgets/signin_button.dart';

class LoginBasic extends StatelessWidget {

  late ProviderLogin _providerLogin;


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    _providerLogin = Provider.of<ProviderLogin>(context);


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
                    height: MediaQuery.of(context).size.height / 2.7,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
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
                    child: Column(
                      children:  [
                         Expanded(flex: 3,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child:  Text('BIENVENIDO',
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: (MediaQuery.of(context).size.height) / 26.5
                              ),),
                          ),
                        ),
                        Expanded(flex: 7,
                            child: Image.asset(
                          'assets/img/logo_blanco_fudea.png',
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
                            _providerLogin.userName = value.trim();
                          },
                          onChanged: (value) {
                            _providerLogin.userName = value.trim();
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: TextField(
                          textAlign: TextAlign.center,
                          obscureText: _providerLogin.hidePass,
                          decoration: InputDecoration(
                            focusedBorder:const  UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)),
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                            ),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _providerLogin.hidePass = !_providerLogin.hidePass;
                              },
                              child:  Icon(
                                _providerLogin.hidePass ? Icons.visibility : Icons.visibility_off,
                                semanticLabel: _providerLogin.hidePass
                                    ? 'ver contraseña'
                                    : 'ocultar ontraseña',
                              ),
                            ),
                          ),
                          onSubmitted: (value) {
                            _providerLogin.pass = value;
                          },
                          onChanged: (value) {
                            _providerLogin.pass = value;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: (MediaQuery.of(context).size.width) / 1.5,
                        child: SigninButton(whiteBackground: true,
                            child: contenidoBoton(_providerLogin.cargando, 'Log In', true,(MediaQuery.of(context).size.height) / 36.5),
                            onPressed: () async {
                              if (!_providerLogin.cargando &&
                                  _providerLogin.userName.isNotEmpty &&
                                  _providerLogin.pass.isNotEmpty) {
                                _providerLogin.cargando = true;
                                FocusScopeNode currentFocus = FocusScope.of(
                                    context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                _providerLogin.conectarse(context: context, fromDemo: false, fromMenu: false);

                                /*if (_providerLogin.userName ==
                                    'test@test.com' &&
                                    _providerLogin.pass == '123') {
                                  await Future.delayed(const Duration(seconds: 3))
                                      .then((value) {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Home()));

                                  });
                                } else {

                                }*/
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Verifique E-Mail, Contraseña y conexión a internet')));
                              }
                            })
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
