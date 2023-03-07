import 'package:floor/floor.dart';
import 'package:fudea/data/entities/option.dart';

@dao
abstract class OptionDao{

  @Query('SELECT * FROM Option WHERE idEvaluation = :idEvaluation')
  Future<List<Option>> findOptionsByEvaluationId(int idEvaluation);


  @insert
  Future<void> insertSingle(Option elemento);

  @insert
  Future<void> insertMultiple(List<Option> elementos);

  @update
  Future<void> updateSingle(Option elemento);

  @update
  Future<void> updateMultiple(List<Option> elementos);

  @delete
  Future<void> deleteSingle(Option elemento);

  @delete
  Future<void> deleteMultiple(List<Option> elementos);

}