import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager{
  static const String _keySesionActiva = "idSessionActiva";
  static const String _keyIsFirstTime = "isFirstTime";
  static const String _keyNotification = "notification";

  static Future<bool?> getIsFirstTime() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_keyIsFirstTime);
  }

  static Future<void> setIsFirstTime(bool _isFirstTime) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool(_keyIsFirstTime, _isFirstTime);
  }

  static Future<int?> getUsuarioActivo() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getInt(_keySesionActiva);
  }

  static Future<void> setUsuarioActivo(int _idUsuarioActivo) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt(_keySesionActiva, _idUsuarioActivo);
  }

  static Future<bool> removeNotification() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.remove(_keyNotification);
  }

  static Future<String?> getNotification() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_keyNotification);
  }

  static Future<void> setNotification(String _notification) async{
    SharedPreferences.setMockInitialValues({});
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_keyNotification, _notification);
  }

}