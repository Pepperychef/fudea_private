import 'package:floor/floor.dart';

import '../entities/response.dart';

@dao
abstract class ResponseDao{

  @Query('SELECT * FROM Response WHERE idProyecto = :idProyecto')
  Future<List<Response>> findResponsesByVisitId(int idProyecto);

  @Query('SELECT * FROM Response WHERE idPregunta = :idPregunta')
  Future<List<Response>> findResponsesByEvaluationId(int idPregunta);


  @insert
  Future<void> insertSingle(Response elemento);

  @insert
  Future<void> insertMultiple(List<Response> elementos);

  @update
  Future<void> updateSingle(Response elemento);

  @update
  Future<void> updateMultiple(List<Response> elementos);

  @delete
  Future<void> deleteSingle(Response elemento);

  @delete
  Future<void> deleteMultiple(List<Response> elementos);

}