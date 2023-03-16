import 'package:floor/floor.dart';

@entity
class Response {
  @primaryKey
  int? id;
  int idEvaluation;
  int idProyecto;
  int idOption;
  String strOption;

  Response(
      {this.id,
      required this.strOption,
        required this.idProyecto,
      required this.idOption,
      required this.idEvaluation});
}
