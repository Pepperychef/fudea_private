import 'package:floor/floor.dart';
import 'package:fudea/data/entities/visit.dart';

@dao
abstract class VisitDao{

  @Query('SELECT * FROM Visit')
  Future<List<Visit>> findEverything();

  @insert
  Future<void> insertSingle(Visit elemento);

  @insert
  Future<void> insertMultiple(List<Visit> elementos);

  @update
  Future<void> updateSingle(Visit elemento);

  @update
  Future<void> updateMultiple(List<Visit> elementos);

  @delete
  Future<void> deleteSingle(Visit elemento);

  @delete
  Future<void> deleteMultiple(List<Visit> elementos);

}