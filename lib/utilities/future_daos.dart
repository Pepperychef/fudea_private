import 'package:fudea/data/daos/evaluation_dao.dart';
import 'package:fudea/data/daos/option_dao.dart';
import 'package:fudea/data/daos/response_dao.dart';
import 'package:fudea/data/daos/visit_dao.dart';

import 'constantes.dart';

class FutureDaos{
  Future<EvaluationDao> evaluationDaoFuture() async {
    final _database = await Constantes().databaseFuture();
    final _dao = _database.evaluationDao;
    return _dao;
  }
  Future<OptionDao> optionDaoFuture() async {
    final _database = await Constantes().databaseFuture();
    final _dao = _database.optionDao;
    return _dao;
  }
  Future<ResponseDao> responseDaoFuture() async {
    final _database = await Constantes().databaseFuture();
    final _dao = _database.responseDao;
    return _dao;
  }
  Future<VisitDao> visitDaoFuture() async {
    final _database = await Constantes().databaseFuture();
    final _dao = _database.visitDao;
    return _dao;
  }
}