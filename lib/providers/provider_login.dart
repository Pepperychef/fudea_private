import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
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

  late Conexiones conexiones;

  ProviderLogin(BuildContext _context,
      {required this.url,
        required this.db,
        required this.demo}) {
    setConexiones();
 //   checkConectadoOdoo();
  }

  void setConexiones() {
    conexiones = Conexiones(url: url, db: db);
  }
/*
  void checkConectadoOdoo() async {
    int? idUsuario = await SharedPreferencesManager.getUsuarioActivo();
    resUsersDao = await FutureDaos().resUsersDaoFuture();
    if (idUsuario != 0 && idUsuario != null) {
      user = await resUsersDao!.encuentraUsuarioPorId(idUsuario);
      if (user!.partnerIdOdoo != 0) {
        if (user!.login != 'demo') conectadoOdoo = true;
      }
    }
    if (conectadoOdoo == null) {
      conectadoOdoo = false;
    }
    notifyListeners();
  }
*/


  Future<void> conectarse(
      {required BuildContext context,
        required bool fromDemo,
        required bool fromMenu,}) async {
    //await getUltimaConexion();


    Map<Permission, PermissionState> permission =
    await PermissionsPlugin.checkPermissions([
      Permission.RECORD_AUDIO,
      Permission.ACCESS_FINE_LOCATION,
      Permission.CAMERA,
      Permission.WRITE_EXTERNAL_STORAGE
    ]);

    if(permission.containsValue(PermissionState.GRANTED)){
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
        print('UwU');

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Home(
              user: userName,
              userID: _resp.toJson()['userId'],
              userName:_resp.toJson()['userName'] ,
            )));

      }
      _cargando = false;

    }else{
      await PermissionsPlugin.requestPermissions([
        Permission.RECORD_AUDIO,
        Permission.ACCESS_FINE_LOCATION,
        Permission.CAMERA,
        Permission.WRITE_EXTERNAL_STORAGE
      ]);
    }





    notifyListeners();
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

}