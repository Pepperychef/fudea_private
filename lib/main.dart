import 'package:flutter/material.dart';
import 'package:fudea/pages/login_basic.dart';
import 'package:fudea/providers/provider_login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: LoginBasic(),
        providers: [
        ChangeNotifierProvider.value(value: ProviderLogin(context, url: '', db: '', demo: true
        )),
      ],

      )
    );
  }
}


