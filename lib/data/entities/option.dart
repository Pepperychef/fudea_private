import 'package:floor/floor.dart';

@entity
class Option{
  @primaryKey
  int? id;
  int idEvaluation;
  int idOption;
  String strOption;

  Option({
    this.id,
    required this.idEvaluation,
    required this.idOption,
    required this.strOption
});


}