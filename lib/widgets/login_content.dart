import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/utilities/local_theme.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../providers/provider_login.dart';
import 'contenido_boton_Login.dart';
import 'signin_button.dart';

class LoginContent extends StatelessWidget {
  List<String> sugestions = <String>[];
  late ProviderLogin _providerLogin;


  @override
  Widget build(BuildContext context) {
    List<Widget> elementosLista = [];
    _providerLogin = Provider.of<ProviderLogin>(context);
    elementosLista
        .add(SizedBox(height: MediaQuery.of(context).size.height * 0.01));
    elementosLista.add(emailField(context));
    elementosLista.add(passwordField(context));
    elementosLista.add(rememberMeCheck(context));
    elementosLista.add(connectButton(context));
    elementosLista.add(separatorOr(context));
    


    return Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: elementosLista,
              )),
        ));
  }


  Widget emailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(right: 65.0, left: 15.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.center,
        controller: TextEditingController(
          text: _providerLogin.userName
        ),
        decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            hintText: "E-Mail",
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
    );
  }

  Widget passwordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: TextField(
        textAlign: TextAlign.center,
        obscureText: _providerLogin.hidePass,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          prefixIcon: const Icon(
            Icons.vpn_key,
          ),
          hintText: "Contraseña",
          suffixIcon: GestureDetector(
            onTap: () {
              _providerLogin.hidePass = !_providerLogin.hidePass;
            },
            child: Icon(
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
    );
  }

  Widget rememberMeCheck(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _providerLogin.recordarme,
            onChanged: (value) {
              _providerLogin.recordarme = value;
            },
            checkColor: Colors.blueGrey,
            activeColor: Colors.blueGrey,
          ),
          Text(
            'Recuerdame',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  Widget connectButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: (MediaQuery.of(context).size.width) / 1.5,
      child: SigninButton(
          child: contenidoBoton(_providerLogin.cargando, 'Conectar', false, (MediaQuery.of(context).size.height) / 26.5),
          onPressed: () {
            if (!_providerLogin.cargando &&
                _providerLogin.userName.isNotEmpty &&
                _providerLogin.pass.isNotEmpty) {
              _providerLogin.cargando = true;
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

/*
              _providerLogin.conectarse(
                context: context,
                fromDemo: false,
                fromMenu: fromMenu,
              );*/

              print('si se cumplen condiciones para logearse');
            } else {
              print('no se cumplen condiciones para logearse');
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Verifique E-Mail, Contraseña y conexión a internet')));
            }
          }),
    );
  }

  Widget connectDemoButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: (MediaQuery.of(context).size.width) / 1.5,
      child: SigninButton(
          whiteBackground: true,
          offButton: true,
          child: contenidoBoton(
              _providerLogin.cargando, 'Conectar como Invitado', false, (MediaQuery.of(context).size.height) / 26.5),
          onPressed: () {
            if (!_providerLogin.cargando) {
              _providerLogin.pass = 'demo';
              _providerLogin.userName = 'demo';
              _providerLogin.cargando = true;
              _providerLogin.demo = true;
              /*_providerLogin.conectarse(
                context: context,
                fromDemo: true,
                fromMenu: false,
              );*/
              print('si se cumplen condiciones para logearse');
            } else {
              print('no se cumplen condiciones para logearse');
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Verifique conexión a internet')));
            }
          }),
    );
  }


  Widget separatorOr(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: const Divider(
              thickness: 1,
              indent: 20,
              height: 60,
            )),
      ),
      const Text(
        "O",
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: const Divider(
              thickness: 1,
              endIndent: 20,
              height: 60,
            )),
      ),
    ]);
  }

  void mensajeDemo(BuildContext context) {

    Toast.show('No se permite la edición en el modo Demo',
        duration: Toast.lengthLong);
  }
}