import 'package:floor/floor.dart';

@entity
class Visit{
  @primaryKey
  int? id;
  int idProyecto;
  int idSalidaTerreno;
  String dirContacto;
  String emailContacto;
  bool incluyeEvaluacion;
  String nombreBeneficiario;
  String nombreProyecto;
  String nombreInstrumento;
  String telefonoContacto;
  double latitud;
  double longitud;
  bool guardado;

  Visit({
    this.id,
    required this.dirContacto,
    required this.emailContacto,
    required this.idProyecto,
    required this.idSalidaTerreno,
    required this.incluyeEvaluacion,
    required this.nombreBeneficiario,
    required this.nombreInstrumento,
    required this.nombreProyecto,
    required this.telefonoContacto,
    required this.latitud,
    required this.longitud,
    required this.guardado
});






}