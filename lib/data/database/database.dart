import 'package:floor/floor.dart';
import 'package:fudea/data/daos/evaluation_dao.dart';
import 'package:fudea/data/daos/option_dao.dart';
import 'package:fudea/data/daos/response_dao.dart';
import 'package:fudea/data/daos/visit_dao.dart';
import 'package:fudea/data/entities/evaluation.dart';
import 'package:fudea/data/entities/option.dart';
import 'package:fudea/data/entities/response.dart';
import 'package:fudea/data/entities/visit.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'database.g.dart';

@Database(version: 1, entities: [Evaluation, Option, Response, Visit])
abstract class AppDatabase extends FloorDatabase {
  EvaluationDao get evaluationDao;
  OptionDao get optionDao;
  ResponseDao get responseDao;
  VisitDao get visitDao;

  Future<void> clearAllTables() async {
    await database.execute('DELETE FROM Evaluation');
    await database.execute('DELETE FROM Option');
    await database.execute('DELETE FROM Response');
    await database.execute('DELETE FROM Visit');
  }
}
