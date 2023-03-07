import 'package:floor/floor.dart';

@entity
class Evaluation {
  @primaryKey
  int? id;
  int idVisita;
  int idPregunta;
  int secuencia;
  String textoPregunta;
  String tipo;

  Evaluation({
    this.id,
    required this.idVisita,
    required this.idPregunta,
    required this.secuencia,
    required this.textoPregunta,
    required this.tipo
});



}