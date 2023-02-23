import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
