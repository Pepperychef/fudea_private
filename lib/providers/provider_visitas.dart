

import 'package:flutter/cupertino.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import '../data/entities/visit.dart';

class ProviderVisitas with ChangeNotifier{

  List<Visit> visits;
  String localFilePathEncuesta = '';
  String localFilePathResumen = '';

  ProviderVisitas({required this.visits}){
    init();
  }

  init() async{
    String customPathEncuesta = '/fudea_audio_visit_';
    String customPathResumen = '/fudea_audio_';
    io.Directory appDocDirectory;
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }

    localFilePathEncuesta = appDocDirectory.path +
        customPathEncuesta +
        DateTime.now().millisecondsSinceEpoch.toString();


    localFilePathResumen = appDocDirectory.path +
        customPathResumen +
        DateTime.now().millisecondsSinceEpoch.toString();

  }


}