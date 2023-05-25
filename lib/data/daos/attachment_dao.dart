import 'package:floor/floor.dart';
import 'package:fudea/data/entities/attachment.dart';

@dao
abstract class AttachmentDao{

  @Query('SELECT * FROM Attachment WHERE idVisita = :idVisita')
  Future<List<Attachment>> findAttachmentsByVisitId(int idVisita);

  @Query('SELECT * FROM Attachment WHERE idVisita = :idVisita AND idEvaluation = :idEvaluation AND type = :type LIMIT 1')
  Future<Attachment?> findAttachmentsByEvaluationId(int idVisita, int idEvaluation, String type);

  @Query('SELECT * FROM Attachment WHERE idVisita = :idVisita AND idEvaluation = :idEvaluation AND type = :type LIMIT 1')
  Future<Attachment?> findAttachmentsByEvaluationIdAndType(int idVisita, int idEvaluation, String type);


  @insert
  Future<void> insertSingle(Attachment elemento);

  @insert
  Future<void> insertMultiple(List<Attachment> elementos);

  @update
  Future<void> updateSingle(Attachment elemento);

  @update
  Future<void> updateMultiple(List<Attachment> elementos);

  @delete
  Future<void> deleteSingle(Attachment elemento);

  @delete
  Future<void> deleteMultiple(List<Attachment> elementos);

}