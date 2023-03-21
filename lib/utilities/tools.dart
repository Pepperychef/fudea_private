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

Future<List<Map<int,Option>>> fillOptions (List<Evaluation> preguntas, OptionDao optionDao) async{

  List<Map<int,Option>> options= [];

  for (Evaluation pregunta in preguntas) {
    List<Option> _tmp = await optionDao.findOptionsByEvaluationId(pregunta.idPregunta);
    Map<int,Option> _tmp2= {for (var item in _tmp) item.idOption : item};

    options.add(_tmp2);
  }


  return options;


}

Future<void> saveAttachemnts({required Attachment data, required bool finalSave, required int idEvaluation, required String type})async{

  String _path = data.binaryFile;
  AttachmentDao _dao = await FutureDaos().attachmentDaoFuture();

  Attachment? _tmp = await _dao.findAttachmentsByEvaluationIdAndType(data.idVisita, idEvaluation, type);

  if(finalSave){
    String _tmpbi = await codifyBinary(_path);
    data = Attachment(id: data.id, idVisita: data.idVisita, type: data.type, binaryFile: _tmpbi, idEvaluation: idEvaluation);
    _dao.updateSingle(data);
  }else{
    if(_tmp != null){
      data = Attachment(id: data.id, idVisita: data.idVisita, type: data.type, binaryFile: data.binaryFile, idEvaluation: idEvaluation);
      _dao.updateSingle(data);
    }else{
      _dao.insertSingle(data);
    }
  }

}

Future<List<Visit>> fetchSavedVisits() async{
  VisitDao visitDao = await FutureDaos().visitDaoFuture();

  List<Visit> visitasGuardadas = await visitDao.findSaved();

  return visitasGuardadas;


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



Future<void> sendFilesToServer ({required List<Visit> visitas, required int idUsuario})async{

  AttachmentDao _attachmentDao = await FutureDaos().attachmentDaoFuture();
  ResponseDao _responseDao = await FutureDaos().responseDaoFuture();

  List visitas2=[];
  for (Visit visit in visitas){

    List<Response> _tmp = await _responseDao.findResponsesByVisitId(visit.idProyecto);
    List respuestas= [];
    for(Response response in _tmp){
      Map respData = {
        "id_pregunta": response.idEvaluation.toString(),
        "id_respuesta": response.idOption.toString(),
        "texto_respuesta": response.strOption.toString(),
      };
      respuestas.add(respData);
    }
    List<Attachment> attachments = await _attachmentDao.findAttachmentsByVisitId(visit.idProyecto);

    String imgActa= '';
    String imgEvidencia = '';
    String arch_audio = '';

    for(Attachment att in attachments){

      String binary = await codifyBinary(att.binaryFile);

      case2(att.type, {
        'img_acta': imgActa = binary,
        'img_evidencia': imgEvidencia = binary,
        'arch_audio': arch_audio = arch_audio
      }
      );

    }

    Map visitData = {
      "id_visita": visit.idProyecto.toString(),
      "img_acta": imgActa,
      "img_evidencia": imgEvidencia,
      "arch_audio": arch_audio,
      "posicion":{
        "latitud": '0',
        "Longitud": '0',
      } ,
      "evaluacion": respuestas.toString(),

    };
    visitas2.add(visitData);

  }

  Map data = {
    'idUsuario': idUsuario.toString(),
    'visitas': visitas2.toString()
  };

  Constantes constantes = Constantes();

  var response = await http.post(Uri.parse('${constantes.url}upload'), body: data);

  if(response.statusCode != 400){
    AppDatabase _db = await constantes.databaseFuture();
    await _db.clearAllTables();
  }


}
