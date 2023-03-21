import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudea/data/daos/response_dao.dart';
import 'package:fudea/data/daos/visit_dao.dart';
import 'package:fudea/data/entities/attachment.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:fudea/utilities/future_daos.dart';
import 'package:fudea/utilities/tools.dart';
import 'package:image_picker/image_picker.dart';

import '../data/entities/response.dart';

class ProviderSummary with ChangeNotifier{


  Future<Visit> saveResponses(List<List<Response>> respuestas, Visit visit) async{

    FutureDaos futureDaos = FutureDaos();
    ResponseDao _dao = await futureDaos.responseDaoFuture();
    VisitDao _vdao = await futureDaos.visitDaoFuture();

    for (List<Response> _list in respuestas){
      await _dao.insertMultiple(_list);
    }

    Visit _tmp = Visit(
      id: visit.id,
        dirContacto: visit.dirContacto,
        emailContacto: visit.emailContacto,
        idProyecto: visit.idProyecto,
        idSalidaTerreno: visit.idSalidaTerreno,
        incluyeEvaluacion: visit.incluyeEvaluacion,
        nombreBeneficiario: visit.nombreBeneficiario,
        nombreInstrumento: visit.nombreInstrumento,
        nombreProyecto: visit.nombreProyecto,
        telefonoContacto: visit.telefonoContacto,
        guardado: true);

    _vdao.updateSingle(_tmp);

    return _tmp;

  }

  void getImage(BuildContext context,  int idVisita, String tipoFoto
  ) async {

    Scaffold.of(context).showBottomSheet((_context) => Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white.withOpacity(0.2),
        height: (MediaQuery.of(context).size.height) / 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Selecciona el metodo de ingreso',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () async {
                        await ImagePicker()
                            .pickImage(
                            source: ImageSource.gallery,
                            maxWidth: 500,
                            maxHeight: 500)
                            .then((image) {
                          if (image!.path != null) {
                            String uri = image.path;
                            Attachment _data = Attachment(idVisita: idVisita, type: tipoFoto, binaryFile: uri, idEvaluation: 0);
                            saveAttachemnts(data:_data, finalSave: false, idEvaluation: 0, type: tipoFoto);
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                           Icon(
                            Icons.perm_media,
                            color: Colors.black54,
                            size: 50.0,
                          ),
                          Text(
                            'Galeria',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      onTap: () async {
                        await ImagePicker()
                            .pickImage(
                            source: ImageSource.camera,
                            maxWidth: 500,
                            maxHeight: 500)
                            .then((image) {
                          if (image!.path != null) {
                            String uri = image.path;
                            Attachment _data = Attachment(idVisita: idVisita, type: tipoFoto, binaryFile: uri, idEvaluation: 0);
                            saveAttachemnts(data:_data, finalSave: false, idEvaluation: 0, type: tipoFoto);
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black54,
                            size: 50.0,
                          ),
                          Text(
                            'Camara',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }
}