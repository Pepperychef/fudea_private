import 'dart:convert';
import 'dart:io';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:retry/retry.dart';

const String alfaSuccess = "success";
const String alfaError = "error";
const String alfaWithoutConnection = "without_connection";

class Conexiones {
  OdooClient? client;
  OdooSession? session;
  String url;
  String db;

  Conexiones({required this.url, required this.db}) {
    initClient();
  }

  static Future<bool> checkConection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> checkOdooUp(var client) async {
    try {
      await client.connect();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> checkAlfaDataModuleUp(String _url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({})));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void initClient() {
    client = OdooClient(url);
  }

  Future<ConAuthRes> authenticate(String login, String password) async {
    bool coneccionInternet = await checkConection();
    if (coneccionInternet) {
      final r = RetryOptions(maxAttempts: 3);
      try {
        session = await r.retry(
            () => client!
                .authenticate(db, login, password)
                .timeout(Duration(seconds: 5)), retryIf: (e) {
          if (e.toString().contains("AccessDenied")) {
            return false;
          } else {
            return true;
          }
        });
        return ConAuthRes(
            error: false,
            id: session!.id,
            userId: session!.userId,
            partnerId: session!.partnerId,
            userLogin: session!.userLogin,
            userName: session!.userName);
      } catch (e) {
        print("Error Autenticando: $e");
        if (e.toString().contains("AccessDenied")) {
          return ConAuthRes(error: true, typeError: "AccessDenied");
        } else {
          return ConAuthRes(error: true, typeError: "CheckConnection");
        }
      }
    } else {
      return ConAuthRes(error: true, typeError: "CheckConnection");
    }
  }

  Future<AlfaResponse> callMethod(Map params, {timeout: 15, repeat: 3}) async {
    print('---Inicio de callMethod modelo:---');
    bool coneccionInternet = await checkConection();
    if (coneccionInternet) {
      print('---Inicio de callMethod modelo:---Conectado a internet');
      final r = RetryOptions(maxAttempts: repeat);
      try {
        var res = await r.retry(
            () => client!.callKw(params).timeout(Duration(seconds: timeout)));
        if (res != null) {
          print('---Fin de callMethod modelo: ---$res');
          return AlfaResponse(state: alfaSuccess, resp: res);
        } else {
          print('---Fin de callMethod modelo: ---');
          return AlfaResponse(state: alfaSuccess, resp: []);
        }
      } catch (e) {
        print("Error: $e | $params");
        print('---Fin de callMethod modelo: ---Error');
        return AlfaResponse(state: alfaError, resp: [], msg: 'Error');
      }
    } else {
      print('---Fin de callMethod modelo: ---Sin conexion');
      return AlfaResponse(
          state: alfaWithoutConnection, resp: [], msg: 'Sin conexion');
    }
  }

  Future<AlfaResponse> callController(String path, String method, Map values,
      {timeout: 15, repeat: 3}) async {
    bool coneccionInternet = await checkConection();
    if (coneccionInternet) {
      final r = RetryOptions(maxAttempts: repeat);
      try {
        var res = await r.retry(() => client!
            .callRPC(path, method, values)
            .timeout(Duration(seconds: timeout)));
        if (res != null) {
          return AlfaResponse(state: alfaSuccess, resp: res);
        } else {
          return AlfaResponse(state: alfaSuccess, resp: {});
        }
      } catch (e) {
        print("Error: $e | $path");
        return AlfaResponse(state: alfaError, resp: {}, msg: 'Error');
      }
    } else {
      return AlfaResponse(
          state: alfaWithoutConnection, resp: {}, msg: 'Sin conexion');
    }
  }
}

class ConAuthRes {
  bool error;
  String? typeError;
  String? id;
  int? userId;
  int? partnerId;
  String? userLogin;
  String? userName;

  ConAuthRes({
    required this.error,
    this.typeError,
    this.id,
    this.userId,
    this.partnerId,
    this.userLogin,
    this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'partnerId': partnerId,
      'userLogin': userLogin,
      'userName': userName,
    };
  }

  ConAuthRes fromJson(Map<String, dynamic> json) {
    return ConAuthRes(
      error: json['error'] as bool,
      id: json['id'] as String,
      userId: json['userId'] as int,
      partnerId: json['partnerId'] as int,
      userLogin: json['userLogin'] as String,
      userName: json['userName'] as String,
    );
  }
}

class AlfaResponse {
  String state;
  dynamic resp;
  String? msg;

  AlfaResponse({required this.state, required this.resp, this.msg});
}
