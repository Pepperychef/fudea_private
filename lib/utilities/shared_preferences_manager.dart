import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager{
  static const String _keyRemember = "rememberMe";
  static const String _keyUser = "user";
  static const String _keyPassword = "password";
  static const String _keyUserID = "userId";
  static const String _keyUserName = "userName";

  static Future<bool?> getRemember() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_keyRemember);
  }

  static Future<void> setRemember(bool _value) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool(_keyRemember, _value);
  }

  static Future<String?> getUser() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_keyUser);
  }

  static Future<void> setUser(String _value) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_keyUser, _value);
  }

  static Future<String?> getPassword() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_keyPassword);
  }

  static Future<void> setPassword(String _value) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_keyPassword, _value);
  }

  static Future<String?> getUserId() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_keyUserID);
  }

  static Future<void> setUserId(String _value) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_keyUserID, _value);
  }

  static Future<String?> getUserName() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_keyUserName);
  }

  static Future<void> setUserName(String _value) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_keyUserName, _value);
  }

}