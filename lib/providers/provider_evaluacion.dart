import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/data/entities/evaluation.dart';
import 'package:fudea/data/entities/option.dart';
import 'package:fudea/data/entities/response.dart';

class ProviderEvaluacion with ChangeNotifier{

  List<Evaluation> listEvaluation;

  List<Map<int,Option>>listOptions;

  List<List<Response>>listResponses;

  int idActiveEvaluation = 0;

  ProviderEvaluacion({
    required this.listEvaluation,
    required this.listOptions,
    required this.listResponses
});

  void updateResponse(List<Response> response, int index){

    listResponses[index] = response;
    notifyListeners();

  }

}