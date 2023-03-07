import 'package:floor/floor.dart';
import 'package:fudea/data/entities/evaluation.dart';

@dao
abstract class EvaluationDao{

  @Query('SELECT * FROM Evaluation WHERE idVisita = :idVisita')
  Future<List<Evaluation>> findEvaluationsByVisitId(int idVisita);

  @Query('SELECT * FROM Evaluation LIMIT 1')
  Future<Evaluation?> encuentraPrimeraAplicacion();

  @insert
  Future<void> insertSingle(Evaluation elemento);

  @insert
  Future<void> insertMultiple(List<Evaluation> elementos);

  @update
  Future<void> updateSingle(Evaluation elemento);

  @update
  Future<void> updateMultiple(List<Evaluation> elementos);

  @delete
  Future<void> deleteSingle(Evaluation elemento);

  @delete
  Future<void> deleteMultiple(List<Evaluation> elementos);

}