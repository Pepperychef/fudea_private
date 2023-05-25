import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:fudea/data/daos/attachment_dao.dart';
import 'package:fudea/data/entities/attachment.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/utilities/future_daos.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets_encuesta_formulario/grabador.dart' as grabador;

class ProviderGrabadorResumen with ChangeNotifier {
  FlutterAudioRecorder2? recording;
  bool isRecording = false;
  String localFilePath;
  String localFilePathEncuesta;
  String textDuration = '';
  Visit visit;
  int idEvaluation;
  String? savedPath;

  String valueRespuesta = '';

  ProviderGrabadorResumen({
    required this.visit,
    required this.idEvaluation,
    required this.localFilePath,
    required this.localFilePathEncuesta
  }) {
    //init();
  }

  Future<void> init() async {

    recording =
        FlutterAudioRecorder2(localFilePath, audioFormat: AudioFormat.WAV);

    await recording!.initialized;
    getValueRespuesta();
  }

  saveRecording() async {
    await recording!.stop();
    isRecording = false;

    if (localFilePath != '') {
      Attachment _tmp = Attachment(
          idVisita: visit.idProyecto,
          type: 'arch_audio_summary',
          binaryFile: localFilePath,
          idEvaluation: idEvaluation);
      await saveAttachemnts(
          data: _tmp,
          finalSave: false,
          idEvaluation: idEvaluation,
          type: 'arch_audio_summary');
    }

    notifyListeners();
  }

  deleteRecording() async {
    try {
      await getValueRespuesta();
      String path = valueRespuesta;

      var localFileSystem = const LocalFileSystem();
      File? file;
      if (localFilePath != '') {
        if (localFileSystem.file(localFilePath).existsSync()) {
          file = localFileSystem.file(localFilePath);
        }
      } else {
        if (localFileSystem.file('$path').existsSync()) {
          file = localFileSystem.file('$path');
        }
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> getValueRespuesta() async {
    await recording!.initialized;
    String resp = '';
    AttachmentDao _dao = await FutureDaos().attachmentDaoFuture();
    Attachment? _tmp = await _dao.findAttachmentsByEvaluationId(
        visit.idProyecto, idEvaluation, 'arch_audio_summary');
    if (_tmp != null) {
      resp = _tmp.binaryFile;
      valueRespuesta = resp;
      localFilePath = _tmp.binaryFile;
    }
  }

  startRecording(BuildContext context) async {
    try {

      await init();
      print('test');

      Map<Permission, PermissionStatus> permission = await [
        Permission.microphone,
        //Permission.manageExternalStorage
      ].request();

      bool? haspermission = await FlutterAudioRecorder2.hasPermissions;

      if (haspermission!) {
        var localFileSystem = const LocalFileSystem();
        File? file;
        if (localFilePath != '') {
          if (localFileSystem.file(localFilePath).existsSync()) {
            file = localFileSystem.file(localFilePath);
            if (file != null) {
              file.deleteSync();
              recording!.initialized;
            }
          }
        }

        recording!.start();

        isRecording = true;

        notifyListeners();
      } else {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text("Debes aceptar los permisos")));
        //await PermissionsPlugin.requestPermissions([Permission.RECORD_AUDIO, Permission.WRITE_EXTERNAL_STORAGE]);
      }
    } catch (e) {
      print(e);
    }
  }
}
