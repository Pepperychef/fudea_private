

import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/data/daos/attachment_dao.dart';
import 'package:fudea/data/entities/attachment.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/utilities/future_daos.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utilities/peppery_audio_recorder.dart';
import '../widgets_encuesta_formulario/grabador.dart' as grabador;

class ProviderGrabadorEncuesta with ChangeNotifier{

  Recording recording;
  AudioPlayer audioPlugin = AudioPlayer();
  bool isRecording = false;
  String? localFilePath;
  Stream<int>? _timerStream;
  var _timerSubscription;
  String textDuration = '';
  Visit visit;
  int duration = 0;
  int position = 0;
  int idEvaluation;
  String? savedPath;
  grabador.PlayerState playerState = grabador.PlayerState.stopped;

  late String valueRespuesta;

  ProviderGrabadorEncuesta({required this.recording, required this.visit, required this.idEvaluation}){
    getValueRespuesta();
  }

  saveRecording() async {
    var localFileSystem = const LocalFileSystem();
    var recording = await AudioRecorder.stop();
    bool isRecording = await AudioRecorder.isRecording;
    File file = localFileSystem.file(recording.path);
    this.recording = recording;
    this.isRecording = isRecording;
    this.localFilePath = recording.path;

    _timerSubscription.cancel();
    _timerStream = null;

    duration = recording.duration.inMilliseconds;

    if (this.localFilePath != null) {
      if (this.localFilePath != '') {
        Attachment _tmp = Attachment(idVisita: visit.idProyecto, type: 'arch_audio', binaryFile: this.localFilePath!, idEvaluation: idEvaluation);
        await saveAttachemnts(data: _tmp, finalSave: false, idEvaluation: idEvaluation);
        Source _source = DeviceFileSource(localFilePath!);
        await audioPlugin.setSource(_source);
      }
    }
  }

  deleteRecording() async {
    try {
      await getValueRespuesta();
      String path = valueRespuesta;

      var localFileSystem = const LocalFileSystem();
      File? file;
      if (recording.path != '') {
        if (localFileSystem.file(recording.path).existsSync())
          file = localFileSystem.file(recording.path);
      } else {
        if (localFileSystem.file('$path').existsSync()) {
          file = localFileSystem.file('$path');
        }
      }

      if (file != null) {
        file.deleteSync();
        recording.path = '';
        duration = 0;
        position = 0;
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> getValueRespuesta()async{
    String resp = '';
    AttachmentDao _dao = await FutureDaos().attachmentDaoFuture();
    Attachment? _tmp = await _dao.findAttachmentsByEvaluationId(visit.idProyecto, idEvaluation);
    resp = '${_tmp!.binaryFile}';
    valueRespuesta = resp;

  }

  startRecording(BuildContext context) async {
    try {
      Map<Permission, PermissionState> permission =
      await PermissionsPlugin.checkPermissions([
        Permission.RECORD_AUDIO,
      ]);

      //print('permisos ${permission.values}');

      if (permission.containsValue(PermissionState.GRANTED)) {
        final directory = await getApplicationDocumentsDirectory();

        String _extraId = getIdByDateTime();
        String path =
            '${directory.path}/respuesta${idEvaluation}$_extraId';

        var localFileSystem = const LocalFileSystem();
        File? file;
        if (recording.path != '') {
          if (localFileSystem.file(recording.path).existsSync())
            file = localFileSystem.file(recording.path);
        } else {
          if (localFileSystem.file('$path.m4a').existsSync()) {
            file = localFileSystem.file('$path.m4a');
          }
        }
        if (file != null) {
          file.deleteSync();
        }
        await AudioRecorder.start(
            path: path, audioOutputFormat: AudioOutputFormat.AAC);

        bool isRecording = await AudioRecorder.isRecording;

        recording = new Recording(
            duration: new Duration(),
            path: path,
            extension: '',
            audioOutputFormat: AudioOutputFormat.WAV);

        this.isRecording = isRecording;
        Future.delayed(Duration.zero).then((value) => notifyListeners());

        _timerStream = stopWatchStream();

        _timerSubscription = _timerStream?.listen((int newTick) {
          duration = newTick * 1000;
          notifyListeners();
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("Debes aceptar los permisos")));
        await PermissionsPlugin.requestPermissions(
            [Permission.RECORD_AUDIO, Permission.WRITE_EXTERNAL_STORAGE]);
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<int> stopWatchStream() {
    late StreamController<int> streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  play() async {
    print("PLAYYYY");
    await getValueRespuesta();
    savedPath = valueRespuesta;
    Source _source = DeviceFileSource(localFilePath!);
    if (localFilePath != null) {

      await audioPlugin.play(_source);
      playerState = grabador.PlayerState.playing;
      Future.delayed(Duration.zero).then((value) => notifyListeners());
    } else {
      if (savedPath != '') {
        await audioPlugin.play(_source);
        playerState = grabador.PlayerState.playing;
        Future.delayed(Duration.zero).then((value) => notifyListeners());
      }
    }

    audioPlugin.onPositionChanged.listen((event) async {
      position = event.inMilliseconds;
      notifyListeners();
    });

    audioPlugin.onPlayerStateChanged.listen((PlayerState s) async {
      if (s == PlayerState.stopped) {
        stop();
      }
    });
  }

  stop() async {
    print("STOP");
    final result = await audioPlugin.onPlayerComplete;
    if (result == 1) {
      playerState = grabador.PlayerState.stopped;
      position = 0;
    }
    notifyListeners();
  }



}