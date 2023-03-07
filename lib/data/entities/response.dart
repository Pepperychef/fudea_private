import 'package:floor/floor.dart';

@entity
class Response {
  @primaryKey
  int? id;
  int idEvaluation;
  int idOption;
  String strOption;

  Response(
      {this.id,
      required this.strOption,
      required this.idOption,
      required this.idEvaluation});
}
