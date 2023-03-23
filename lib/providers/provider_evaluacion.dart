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

  bool faltanDatos = true;



  ProviderEvaluacion({
    required this.listEvaluation,
    required this.listOptions,
    required this.listResponses
});

  void updateResponse(List<Response> response, int index){

    listResponses[index] = response;
    notifyListeners();

  }

  Future<bool> onWillPop(BuildContext context) async {


    print(listResponses.length.toString());

    faltanDatos = false;

    for(List<Response> _tmp in listResponses){
      if(_tmp.isEmpty){
        faltanDatos = true;
        break;
      }
    }

    if(faltanDatos){
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Seguro que quieres salir?'),
          content: const Text('Faltan respuestas por completar, Recuerda que no se pueden enviar los datos sin terminar la evaluación'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
                Navigator.of(context).pop();
    } ,
              child: const Text('Si'),
            ),
          ],
        ),
      )) ?? false;
    }else{
      Navigator.of(context).pop();
      return true;
    }

  }

}