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
    required this.telefonoContacto
});






}