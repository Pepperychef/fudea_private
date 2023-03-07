import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fudea/data/daos/option_dao.dart';
import 'package:fudea/data/daos/visit_dao.dart';
import 'package:fudea/data/entities/evaluation.dart';
import 'package:fudea/data/entities/option.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/utilities/future_daos.dart';
import 'package:intl/intl.dart';

import '../data/daos/evaluation_dao.dart';

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
  List<int> fileBytes = File(_path).readAsBytesSync();
  var file = base64Encode(fileBytes);
  return file;
}

String doubleToCurrency(double value, String currency) {
  String result = NumberFormat.currency(
          locale: 'eu', customPattern: '$currency #,###.#', decimalDigits: 0)
      .format(value);
  return result;
}

Future<List<Visit>> saveData({required Map<String, dynamic> list}) async {
  List list1 = list['VISITAS'];

  EvaluationDao evaluationDao = await FutureDaos().evaluationDaoFuture();
  OptionDao optionDao = await FutureDaos().optionDaoFuture();
  VisitDao visitDao = await FutureDaos().visitDaoFuture();

  Evaluation ?tmp = await evaluationDao.encuentraPrimeraAplicacion();

  if(tmp == null){
    for (Map map1 in list1) {
      Visit visit =  Visit(
        idProyecto: map1['ID proyecto'],
        idSalidaTerreno: map1['ID salida terreno'],
        dirContacto: map1['dirección contacto'].toString(),
        emailContacto: map1['email contacto'].toString(),
        incluyeEvaluacion: map1['incluye evaluacion'],
        nombreBeneficiario: map1['nombre beneficiario'].toString(),
        nombreInstrumento: map1['nombre instrumento'].toString(),
        nombreProyecto: map1['nombre proyecto'].toString(),
        telefonoContacto: map1['teléfono contacto'].toString(),
      );

      for (Map map2 in map1['evaluacion']) {
        Evaluation eval = Evaluation(
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
