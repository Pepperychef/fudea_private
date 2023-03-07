import 'package:floor/floor.dart';

import '../entities/response.dart';

@dao
abstract class ResponseDao{

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