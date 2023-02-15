import 'package:flutter/material.dart';
import 'package:fudea/providers/provider_login.dart';
import 'package:provider/provider.dart';

import '../widgets/login_content.dart';

class LoginPage extends StatelessWidget{
  late ProviderLogin _providerLogin;


  @override
  Widget build(BuildContext context) {

    _providerLogin = Provider.of<ProviderLogin>(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                   /* decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(_providerLogin.imgDefault),
                            fit: BoxFit.cover)),*/
                  ),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5)
                        ,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(top: 15.0),
                              child: Image.asset(
                                'assets/images/logo_login.png',
                                //width: _providerContent.theme!.widthLogoLogin,
                              ),
                              alignment: Alignment.center,
                            )),
                        Expanded(
                          flex: 7,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.only(left: 30.0, right: 30.0),
                                ),
                               /* MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider.value(value: _providerLogin),

                                  ],
                                  child: LoginContent(_providerContent.theme, false,
                                      _providerContent, providerPushNotifications),
                                ),*/
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

}