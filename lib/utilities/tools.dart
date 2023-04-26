import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fudea/data/daos/attachment_dao.dart';
import 'package:fudea/data/daos/option_dao.dart';
import 'package:fudea/data/daos/response_dao.dart';
import 'package:fudea/data/daos/visit_dao.dart';
import 'package:fudea/data/database/database.dart';
import 'package:fudea/data/entities/attachment.dart';
import 'package:fudea/data/entities/evaluation.dart';
import 'package:fudea/data/entities/option.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/utilities/constantes.dart';
import 'package:fudea/utilities/future_daos.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../data/daos/evaluation_dao.dart';
import '../data/entities/response.dart';

String getFirstName(String nombre) {
  if (nombre != null) {
    int charLocation = nombre.indexOf(' ');
    if (charLocation > 0) {
      return nombre.substring(0, charLocation);
    } else
      return '';
  } else
    return '';
}

TValue? case2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue? defaultValue,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }
  return branches[selectedOption];
}

String dateTime2String(DateTime date) {
  String resp;
  String day = '${date.day}'.padLeft(2, '0');
  String month = '${date.month}'.padLeft(2, '0');
  String year = '${date.year}';
  resp = '$day/$month/$year';
  return resp;
}

String dateTime2StringWithHour(DateTime date) {
  String resp;
  String day = '${date.day}'.padLeft(2, '0');
  String month = '${date.month}'.padLeft(2, '0');
  String year = '${date.year}';
  String hour = '${date.hour}'.padLeft(2, '0');
  String minute = '${date.minute}'.padLeft(2, '0');
  resp = '$day/$month/$year $hour:$minute';
  return resp;
}

DateTime string2Datetime(String dateStr) {
  DateTime resp;
  DateTime date = DateTime.parse(dateStr);
  resp = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute,
      date.second, date.millisecond, date.microsecond);
  return resp.toLocal();
}

DateTime string2DatetimeWithOutConvert(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  return date;
}

String time2String(TimeOfDay time) {
  String resp;
  String hour = '${time.hour}'.padLeft(2, '0');
  String minute = '${time.minute}'.padLeft(2, '0');
  resp = '$hour:$minute';
  return resp;
}

TimeOfDay string2Time(String timeStr) {
  TimeOfDay resp;
  resp = TimeOfDay(
      hour: int.parse(timeStr.split(":")[0]),
      minute: int.parse(timeStr.split(":")[1]));
  return resp;
}

String getIdByDateTime() {
  DateTime _now = DateTime.now();
  String _nowStr =
      "${_now.year}${_now.month}${_now.day}${_now.hour}${_now.minute}${_now.second}${_now.millisecond}${_now.microsecond}";
  return _nowStr;
}

Future<String> codifyBinary(String _path) async {
  bool _exists = await File(_path).exists();
  if (_exists) {
    List<int> fileBytes = File(_path).readAsBytesSync();
    var file = base64Encode(fileBytes);
    return file;
  } else {
    return _path;
  }
}

String doubleToCurrency(double value, String currency) {
  String result = NumberFormat.currency(
          locale: 'eu', customPattern: '$currency #,###.#', decimalDigits: 0)
      .format(value);
  return result;
}

Future<List<Map<int, Option>>> fillOptions(
    List<Evaluation> preguntas, OptionDao optionDao) async {
  List<Map<int, Option>> options = [];

  for (Evaluation pregunta in preguntas) {
    List<Option> _tmp =
        await optionDao.findOptionsByEvaluationId(pregunta.idPregunta);
    Map<int, Option> _tmp2 = {for (var item in _tmp) item.idOption: item};

    options.add(_tmp2);
  }

  return options;
}

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'El servicio de GPS esta desactivado. Debe habilitar para continuar')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permisos de ubicación fueron denegados')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Permisos de ubicación estan permanentemente denegados, No se puede solicitar permiso.')));
    return false;
  }
  return true;
}

Future<void> saveAttachemnts(
    {required Attachment data,
    required bool finalSave,
    required int idEvaluation,
    required String type}) async {
  String _path = data.binaryFile;
  AttachmentDao _dao = await FutureDaos().attachmentDaoFuture();

  Attachment? _tmp = await _dao.findAttachmentsByEvaluationIdAndType(
      data.idVisita, idEvaluation, type);

  if (finalSave) {
    String _tmpbi = await codifyBinary(_path);
    data = Attachment(
        id: data.id,
        idVisita: data.idVisita,
        type: data.type,
        binaryFile: _tmpbi,
        idEvaluation: idEvaluation);
    _dao.updateSingle(data);
  } else {
    if (_tmp != null) {
      data = Attachment(
          id: _tmp.id,
          idVisita: data.idVisita,
          type: data.type,
          binaryFile: data.binaryFile,
          idEvaluation: idEvaluation);
      _dao.updateSingle(data);
    } else {
      _dao.insertSingle(data);
    }
  }
}

Future<List<Visit>> fetchSavedVisits() async {
  VisitDao visitDao = await FutureDaos().visitDaoFuture();

  List<Visit> visitasGuardadas = await visitDao.findSaved();

  return visitasGuardadas;
}

Future<List<Visit>> saveData(
    {required Map<String, dynamic> list, required BuildContext context}) async {
  List list1 = list['VISITAS'];

  VisitDao visitDao = await FutureDaos().visitDaoFuture();

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);

  EvaluationDao evaluationDao = await FutureDaos().evaluationDaoFuture();
  OptionDao optionDao = await FutureDaos().optionDaoFuture();

  Evaluation? tmp = await evaluationDao.encuentraPrimeraAplicacion();

  if (tmp == null) {
    for (Map map1 in list1) {
      Visit visit = Visit(
        idProyecto: map1['ID proyecto'],
        idSalidaTerreno: map1['ID salida terreno'],
        dirContacto: map1['dirección contacto'].toString(),
        emailContacto: map1['email contacto'].toString(),
        incluyeEvaluacion: map1['incluye evaluacion'],
        nombreBeneficiario: map1['nombre beneficiario'].toString(),
        nombreInstrumento: map1['nombre instrumento'].toString(),
        nombreProyecto: map1['nombre proyecto'].toString(),
        telefonoContacto: map1['teléfono contacto'].toString(),
        longitud: position.longitude,
        latitud: position.latitude,
        guardado: false,
      );

      for (Map map2 in map1['evaluacion']) {
        Evaluation eval = Evaluation(
          idProyecto: map1['ID proyecto'],
          idVisita: visit.idProyecto,
          tipo: map2['tipo'],
          idPregunta: map2['id_pregunta'],
          secuencia: map2['secuencia'],
          textoPregunta: map2['texto_pregunta'],
        );

        for (List list2 in map2['opciones']) {
          Option option = Option(
              idEvaluation: eval.idPregunta,
              idOption: list2[0],
              strOption: list2[1]);

          await optionDao.insertSingle(option);
        }
        await evaluationDao.insertSingle(eval);
      }
      await visitDao.insertSingle(visit);
    }
  }

  List<Visit> listResponse = await visitDao.findEverything();
  return listResponse;
}

Future<void> sendFilesToServer(
    {required List<Visit> visitas,
    required int idUsuario,
    required BuildContext context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // The loading indicator
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          // Some text
          Text('Cargando...')
        ],
      ),
    ),
  );

  AttachmentDao _attachmentDao = await FutureDaos().attachmentDaoFuture();
  ResponseDao _responseDao = await FutureDaos().responseDaoFuture();
  EvaluationDao _evaluationDao = await FutureDaos().evaluationDaoFuture();

  List visitas2 = [];
  for (Visit visit in visitas) {
    List respuestas = [];

    List<Evaluation> _listPreguntas =
        await _evaluationDao.findEvaluationsByVisitId(visit.idProyecto);

    for (Evaluation evaluation in _listPreguntas) {
      List<Response> _tmp =
          await _responseDao.findResponsesByEvaluationId(evaluation.idPregunta);

      Map respData = {
        "id_pregunta": _tmp.first.idEvaluation.toString(),
        "id_respuesta": List.generate(
            _tmp.length, (index) => _tmp[index].idOption.toString()),
        "texto_respuesta": _tmp.first.strOption,
      };
      respuestas.add(respData);
    }

    List<Attachment> attachments =
        await _attachmentDao.findAttachmentsByVisitId(visit.idProyecto);

    String imgActa = '';
    String imgEvidencia = '';
    String arch_audio = '';
    String arch_audio_resumen = '';

    for (Attachment att in attachments) {
      String binary = await codifyBinary(att.binaryFile);

      case2(att.type, {
        'img_acta': imgActa = binary,
        'img_evidencia': imgEvidencia = binary,
        'arch_audio': arch_audio = binary,
        'arch_audio_summary': arch_audio_resumen = binary
      });
    }

    List<String> grabaciones = [];

    if (arch_audio != '') {
      grabaciones.add(arch_audio);
    }
    if (arch_audio_resumen != '') {
      grabaciones.add(arch_audio_resumen);
    }

    Map visitData = {
      "id_proyecto": visit.idProyecto.toString(),
      "id_terreno": visit.idSalidaTerreno.toString(),
      "img_acta": imgActa.toString(),
      "img_evidencia": imgEvidencia.toString(),
      "arch_audio": grabaciones,
      "posicion": {
        "latitud": visit.latitud.toString(),
        "Longitud": visit.longitud.toString(),
      },
      "evaluacion": respuestas,
    };
    visitas2.add(visitData);
  }

  Constantes constantes = Constantes();
  print(idUsuario);
  print(visitas2);

  var response = await http.post(Uri.parse('${constantes.url}upload'),
      body: jsonEncode(
          <String, dynamic>{'idUsuario': idUsuario, 'visitas': visitas2}));
    print(response.body);

  await Future.delayed(const Duration(seconds: 2));

  if (response.statusCode != 400) {
    AppDatabase _db = await constantes.databaseFuture();
    await _db.clearAllTables();

    Navigator.of(context).pop();
  }

  Navigator.of(context).pop();
}
