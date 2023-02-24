import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../utilities/conexiones.dart';
import '../utilities/shared_preferences_manager.dart';

class ProviderLogin with ChangeNotifier{

  String url = "";
  String db = "";
  String userName = "";
  bool _hidePass = true;
  String pass = "";
  bool _cargando = false;
  bool demo;

  late Conexiones conexiones;

  ProviderLogin(BuildContext _context,
      {required this.url,
        required this.db,
        required this.demo}) {
    //setConexiones();
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


  Future<void> conectarse(
      {required BuildContext context,
        required bool fromDemo,
        required bool fromMenu,}) async {
    //await getUltimaConexion();
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
      loggedIntoLoginPage = true;
      bool respToken = false;
      int cont = 5;
      while (!respToken && cont > 0) {
        cont--;
        respToken = await getToken(_resp.userId as int);
        if (respToken) {
          if (fromMenu){
            await _deleteGeneralData();
            demo = false;
          }
          await guardarUsuario(_resp.userId as int, _resp.partnerId as int,
              _resp.userName as String);
        } else {
          _resp = await conexiones.authenticate(
              fromDemo ? 'demo' : userName, fromDemo ? 'demo' : pass);
        }
      }
      if (!respToken) {
        conectadoOdoo = false;
        loggedIntoLoginPage = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text("Se agoto el numero de intentos para obtener el token")));
      }
    }
    _cargando = false;

    notifyListeners();
  }

*/


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