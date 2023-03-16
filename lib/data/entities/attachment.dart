import 'package:floor/floor.dart';

@entity
class Attachment {
  @primaryKey
  int? id;
  int idVisita;
  int idEvaluation;
  String type;
  String binaryFile;

  Attachment({
    this.id,
    required this.idVisita,
    required this.idEvaluation,
    required this.type,
    required this.binaryFile,
});



}