import 'package:floor/floor.dart';

@entity
class Evaluation {
  @primaryKey
  int? id;
  int idVisita;
  int idPregunta;
  int idProyecto;
  int secuencia;
  String textoPregunta;
  String tipo;

  Evaluation({
    this.id,
    required this.idVisita,
    required this.idPregunta,
    required this.idProyecto,
    required this.secuencia,
    required this.textoPregunta,
    required this.tipo
});



}