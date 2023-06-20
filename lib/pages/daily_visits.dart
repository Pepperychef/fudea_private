import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:fudea/data/entities/evaluation.dart';
import 'package:fudea/data/entities/option.dart';
import 'package:fudea/data/entities/response.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/pages/summary.dart';
import 'package:fudea/providers/provider_evaluacion.dart';
import 'package:fudea/providers/provider_grabador_resumen.dart';
import 'package:fudea/providers/provider_summary.dart';
import 'package:fudea/providers/provider_visitas.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../data/daos/evaluation_dao.dart';
import '../data/daos/option_dao.dart';
import '../utilities/future_daos.dart';

class DailyVisits extends StatelessWidget {
  late ProviderVisitas _providerVisitas;

  @override
  Widget build(BuildContext context) {
    _providerVisitas = Provider.of<ProviderVisitas>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(28, 59, 112, 1),
                                Color.fromRGBO(0, 95, 146, 1)
                              ],
                            )),
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height) / 8.5,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(
                                top:
                                    (MediaQuery.of(context).size.height) / 16.5,
                                right: (MediaQuery.of(context).size.height) /
                                    26.5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    iconSize:
                                        (MediaQuery.of(context).size.height) /
                                            26.5,
                                    color: Colors.white,
                                    icon: const Icon(CupertinoIcons.back)),
                                Text(
                                  'VISITAS DIARIAS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          (MediaQuery.of(context).size.height) /
                                              35.5),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: (MediaQuery.of(context).size.height) /
                                      46.5),
                              child: Text(
                                DateFormat.MMMEd('es_US')
                                    .format(DateTime.now()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        (MediaQuery.of(context).size.height) /
                                            46.5),
                              ),
                              margin: EdgeInsets.only(
                                  left: (MediaQuery.of(context).size.height) /
                                      26.5),
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5),
                                      topLeft: Radius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5)),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color.fromRGBO(225, 191, 0, 1),
                                      Color.fromRGBO(240, 125, 0, 1)
                                    ],
                                  )),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: List.generate(
                              _providerVisitas.visits.length, (index) {
                            return GestureDetector(
                              onTap: () async {
                                if (!_providerVisitas.visits[index].guardado) {
                                  OptionDao optionDao =
                                      await FutureDaos().optionDaoFuture();
                                  EvaluationDao evaluationDao =
                                      await FutureDaos().evaluationDaoFuture();

                                  List<Evaluation> listEvaluation =
                                      await evaluationDao
                                          .findEvaluationsByVisitId(
                                              _providerVisitas
                                                  .visits[index].idProyecto);

                                  List<Map<int, Option>> listOptions =
                                      await fillOptions(
                                          listEvaluation, optionDao);

                                  final directory =
                                      await getApplicationDocumentsDirectory();
                                  String _extraId = getIdByDateTime();

                                  List<List<Response>> listResponses =
                                      List.generate(
                                          listEvaluation.length, (index) => []);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MultiProvider(
                                        child: Summary(
                                          localId: _providerVisitas
                                              .visits[index].idProyecto,
                                          visit: _providerVisitas.visits[index],
                                          visitPositon: index,
                                        ),
                                        providers: [
                                          ChangeNotifierProvider.value(
                                              value: ProviderGrabadorResumen(
                                                  idEvaluation: _providerVisitas
                                                      .visits[index].idProyecto,
                                                  visit: _providerVisitas
                                                      .visits[index],
                                                  localFilePathEncuesta:
                                                      _providerVisitas
                                                          .localFilePathEncuesta,
                                                  localFilePath: _providerVisitas
                                                          .localFilePathResumen +
                                                      '${_providerVisitas.visits[index].idProyecto}')),
                                          ChangeNotifierProvider.value(
                                              value: _providerVisitas),
                                          ChangeNotifierProvider.value(
                                              value: ProviderSummary()),
                                          ChangeNotifierProvider.value(
                                              value: ProviderEvaluacion(
                                                  listEvaluation:
                                                      listEvaluation,
                                                  listOptions: listOptions,
                                                  listResponses: listResponses))
                                        ]);
                                  }));
                                }
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(
                                      (MediaQuery.of(context).size.height) /
                                          46.5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          (MediaQuery.of(context).size.height) /
                                              46.5),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: _providerVisitas
                                                .visits[index].guardado
                                            ? <Color>[
                                                Colors.grey,
                                                Colors.black45
                                              ]
                                            : <Color>[
                                                Color.fromRGBO(0, 96, 157, 1),
                                                Color.fromRGBO(28, 59, 112, 1)
                                              ],
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _providerVisitas
                                            .visits[index].nombreBeneficiario,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                46.5),
                                      ),
                                      Text(
                                        _providerVisitas
                                            .visits[index].dirContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                46.5),
                                      ),
                                      Text(
                                        _providerVisitas
                                            .visits[index].telefonoContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                46.5),
                                      ),
                                      Text(
                                        _providerVisitas
                                            .visits[index].emailContacto,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                46.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
