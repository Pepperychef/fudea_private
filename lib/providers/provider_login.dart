import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

import '../pages/home.dart';
import '../utilities/conexiones.dart';
import '../utilities/shared_preferences_manager.dart';

class ProviderLogin with ChangeNotifier{

  String url = "";
  String db = "";
  String userName = "";
  bool _hidePass = true;
  String pass = "";
  bool _cargando = false;
  bool? conectadoOdoo;
  bool demo;
  bool? _recordarme = true;
  bool checkConnection = true;
  String userID= '';
  String userRealName = '';
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  late Conexiones conexiones;

  ProviderLogin(BuildContext _context,
      {required this.url,
        required this.db,
        required this.demo}) {
    checkConexion();
    setConexiones();
    checkSavedData();
 //   checkConectadoOdoo();
  }
  Future<void> checkConexion() async {
    bool _checkTmp = checkConnection;
    checkConnection = await Conexiones.checkConection();
    if (_checkTmp != checkConnection) {
      notifyListeners();
    }
  }

  void checkSavedData() async{
    recordarme = await SharedPreferencesManager.getRemember()??true;
    userName = await SharedPreferencesManager.getUser()??'';
    pass = await SharedPreferencesManager.getPassword()??'';
    userID = await SharedPreferencesManager.getUserId()??'';
    userRealName = await SharedPreferencesManager.getUserName()??'';
    controllerUser.text = userName;
    controllerPassword.text = pass;

    notifyListeners();

    print('test');


  }

  void setConexiones() {
    conexiones = Conexiones(url: url, db: db);
  }

  Future<void> conectarse(
      {required BuildContext context,
        required bool fromDemo,
        required bool fromMenu,}) async {

    await checkConexion();

    if(checkConnection){
      Map<Permission, PermissionStatus> permission = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.locationWhenInUse,
        Permission.microphone,
        Permission.manageExternalStorage,
        Permission.storage
      ].request();

      if(permission.containsValue(PermissionStatus.granted)){
        ConAuthRes _resp = await conexiones.authenticate(
            fromDemo ? 'demo' : userName, fromDemo ? 'demo' : pass);
        if (_resp.error) {
          conectadoOdoo = false;
          String _msg = "";
          if (_resp.typeError == 'AccessDenied') {
            _msg = "Usuario y/o Contraseña incorrectos";
          } else {
            _msg = "Revise su conexión a internet";
          }
          Toast.show(_msg);
        } else {
          conectadoOdoo = true;


          _resp = await conexiones.authenticate(
              fromDemo ? 'demo' : userName, fromDemo ? 'demo' : pass);

          print('${_resp.toJson()['userId']}');
          print('${_resp.toJson()['userName']}');
          print('${_resp.toJson()['id']}');
          print('UwU');

          if(recordarme??false){
            SharedPreferencesManager.setPassword(pass);
            SharedPreferencesManager.setRemember(true);
            SharedPreferencesManager.setUser(userName);
            SharedPreferencesManager.setUserId(_resp.toJson()['userId'].toString());
            SharedPreferencesManager.setUserName(_resp.toJson()['userName'].toString());
          }



          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Home(
                user: userName,
                userID: _resp.toJson()['userId'],
                userName:_resp.toJson()['userName'] ,
                online: checkConnection,
              )));

        }
        _cargando = false;

      }

      notifyListeners();
    }else{
      if(userName != ''){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Home(
              user: userName,
              userID: int.parse(userID),
              userName:userRealName ,
              online: checkConnection,
            )));
      }
    }



  }

  bool get hidePass => _hidePass;

  set hidePass(bool value) {
    _hidePass = value;
    notifyListeners();
  }

  bool get cargando => _cargando;

  set cargando(bool value) {
    _cargando = value;
    notifyListeners();
  }

  bool? get recordarme => _recordarme;

  set recordarme(bool? value) {
    _recordarme = value;
    notifyListeners();
  }

}