// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EvaluationDao? _evaluationDaoInstance;

  OptionDao? _optionDaoInstance;

  ResponseDao? _responseDaoInstance;

  VisitDao? _visitDaoInstance;

  AttachmentDao? _attachmentDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Evaluation` (`id` INTEGER, `idVisita` INTEGER NOT NULL, `idPregunta` INTEGER NOT NULL, `idProyecto` INTEGER NOT NULL, `secuencia` INTEGER NOT NULL, `textoPregunta` TEXT NOT NULL, `tipo` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Option` (`id` INTEGER, `idEvaluation` INTEGER NOT NULL, `idOption` INTEGER NOT NULL, `strOption` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Response` (`id` INTEGER, `idEvaluation` INTEGER NOT NULL, `idProyecto` INTEGER NOT NULL, `idOption` INTEGER NOT NULL, `strOption` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Visit` (`id` INTEGER, `idProyecto` INTEGER NOT NULL, `idSalidaTerreno` INTEGER NOT NULL, `dirContacto` TEXT NOT NULL, `emailContacto` TEXT NOT NULL, `incluyeEvaluacion` INTEGER NOT NULL, `nombreBeneficiario` TEXT NOT NULL, `nombreProyecto` TEXT NOT NULL, `nombreInstrumento` TEXT NOT NULL, `telefonoContacto` TEXT NOT NULL, `latitud` REAL NOT NULL, `longitud` REAL NOT NULL, `guardado` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Attachment` (`id` INTEGER, `idVisita` INTEGER NOT NULL, `idEvaluation` INTEGER NOT NULL, `type` TEXT NOT NULL, `binaryFile` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EvaluationDao get evaluationDao {
    return _evaluationDaoInstance ??= _$EvaluationDao(database, changeListener);
  }

  @override
  OptionDao get optionDao {
    return _optionDaoInstance ??= _$OptionDao(database, changeListener);
  }

  @override
  ResponseDao get responseDao {
    return _responseDaoInstance ??= _$ResponseDao(database, changeListener);
  }

  @override
  VisitDao get visitDao {
    return _visitDaoInstance ??= _$VisitDao(database, changeListener);
  }

  @override
  AttachmentDao get attachmentDao {
    return _attachmentDaoInstance ??= _$AttachmentDao(database, changeListener);
  }
}

class _$EvaluationDao extends EvaluationDao {
  _$EvaluationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _evaluationInsertionAdapter = InsertionAdapter(
            database,
            'Evaluation',
            (Evaluation item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idPregunta': item.idPregunta,
                  'idProyecto': item.idProyecto,
                  'secuencia': item.secuencia,
                  'textoPregunta': item.textoPregunta,
                  'tipo': item.tipo
                }),
        _evaluationUpdateAdapter = UpdateAdapter(
            database,
            'Evaluation',
            ['id'],
            (Evaluation item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idPregunta': item.idPregunta,
                  'idProyecto': item.idProyecto,
                  'secuencia': item.secuencia,
                  'textoPregunta': item.textoPregunta,
                  'tipo': item.tipo
                }),
        _evaluationDeletionAdapter = DeletionAdapter(
            database,
            'Evaluation',
            ['id'],
            (Evaluation item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idPregunta': item.idPregunta,
                  'idProyecto': item.idProyecto,
                  'secuencia': item.secuencia,
                  'textoPregunta': item.textoPregunta,
                  'tipo': item.tipo
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Evaluation> _evaluationInsertionAdapter;

  final UpdateAdapter<Evaluation> _evaluationUpdateAdapter;

  final DeletionAdapter<Evaluation> _evaluationDeletionAdapter;

  @override
  Future<List<Evaluation>> findEvaluationsByVisitId(int idVisita) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Evaluation WHERE idVisita = ?1',
        mapper: (Map<String, Object?> row) => Evaluation(
            id: row['id'] as int?,
            idVisita: row['idVisita'] as int,
            idPregunta: row['idPregunta'] as int,
            idProyecto: row['idProyecto'] as int,
            secuencia: row['secuencia'] as int,
            textoPregunta: row['textoPregunta'] as String,
            tipo: row['tipo'] as String),
        arguments: [idVisita]);
  }

  @override
  Future<Evaluation?> encuentraPrimeraAplicacion() async {
    return _queryAdapter.query('SELECT * FROM Evaluation LIMIT 1',
        mapper: (Map<String, Object?> row) => Evaluation(
            id: row['id'] as int?,
            idVisita: row['idVisita'] as int,
            idPregunta: row['idPregunta'] as int,
            idProyecto: row['idProyecto'] as int,
            secuencia: row['secuencia'] as int,
            textoPregunta: row['textoPregunta'] as String,
            tipo: row['tipo'] as String));
  }

  @override
  Future<void> insertSingle(Evaluation elemento) async {
    await _evaluationInsertionAdapter.insert(
        elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultiple(List<Evaluation> elementos) async {
    await _evaluationInsertionAdapter.insertList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSingle(Evaluation elemento) async {
    await _evaluationUpdateAdapter.update(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMultiple(List<Evaluation> elementos) async {
    await _evaluationUpdateAdapter.updateList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSingle(Evaluation elemento) async {
    await _evaluationDeletionAdapter.delete(elemento);
  }

  @override
  Future<void> deleteMultiple(List<Evaluation> elementos) async {
    await _evaluationDeletionAdapter.deleteList(elementos);
  }
}

class _$OptionDao extends OptionDao {
  _$OptionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _optionInsertionAdapter = InsertionAdapter(
            database,
            'Option',
            (Option item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                }),
        _optionUpdateAdapter = UpdateAdapter(
            database,
            'Option',
            ['id'],
            (Option item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                }),
        _optionDeletionAdapter = DeletionAdapter(
            database,
            'Option',
            ['id'],
            (Option item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Option> _optionInsertionAdapter;

  final UpdateAdapter<Option> _optionUpdateAdapter;

  final DeletionAdapter<Option> _optionDeletionAdapter;

  @override
  Future<List<Option>> findOptionsByEvaluationId(int idEvaluation) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Option WHERE idEvaluation = ?1',
        mapper: (Map<String, Object?> row) => Option(
            id: row['id'] as int?,
            idEvaluation: row['idEvaluation'] as int,
            idOption: row['idOption'] as int,
            strOption: row['strOption'] as String),
        arguments: [idEvaluation]);
  }

  @override
  Future<void> insertSingle(Option elemento) async {
    await _optionInsertionAdapter.insert(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultiple(List<Option> elementos) async {
    await _optionInsertionAdapter.insertList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSingle(Option elemento) async {
    await _optionUpdateAdapter.update(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMultiple(List<Option> elementos) async {
    await _optionUpdateAdapter.updateList(elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSingle(Option elemento) async {
    await _optionDeletionAdapter.delete(elemento);
  }

  @override
  Future<void> deleteMultiple(List<Option> elementos) async {
    await _optionDeletionAdapter.deleteList(elementos);
  }
}

class _$ResponseDao extends ResponseDao {
  _$ResponseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _responseInsertionAdapter = InsertionAdapter(
            database,
            'Response',
            (Response item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idProyecto': item.idProyecto,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                }),
        _responseUpdateAdapter = UpdateAdapter(
            database,
            'Response',
            ['id'],
            (Response item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idProyecto': item.idProyecto,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                }),
        _responseDeletionAdapter = DeletionAdapter(
            database,
            'Response',
            ['id'],
            (Response item) => <String, Object?>{
                  'id': item.id,
                  'idEvaluation': item.idEvaluation,
                  'idProyecto': item.idProyecto,
                  'idOption': item.idOption,
                  'strOption': item.strOption
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Response> _responseInsertionAdapter;

  final UpdateAdapter<Response> _responseUpdateAdapter;

  final DeletionAdapter<Response> _responseDeletionAdapter;

  @override
  Future<List<Response>> findResponsesByVisitId(int idProyecto) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Response WHERE idProyecto = ?1',
        mapper: (Map<String, Object?> row) => Response(
            id: row['id'] as int?,
            strOption: row['strOption'] as String,
            idProyecto: row['idProyecto'] as int,
            idOption: row['idOption'] as int,
            idEvaluation: row['idEvaluation'] as int),
        arguments: [idProyecto]);
  }

  @override
  Future<List<Response>> findResponsesByEvaluationId(int idPregunta) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Response WHERE idEvaluation = ?1',
        mapper: (Map<String, Object?> row) => Response(
            id: row['id'] as int?,
            strOption: row['strOption'] as String,
            idProyecto: row['idProyecto'] as int,
            idOption: row['idOption'] as int,
            idEvaluation: row['idEvaluation'] as int),
        arguments: [idPregunta]);
  }

  @override
  Future<void> insertSingle(Response elemento) async {
    await _responseInsertionAdapter.insert(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultiple(List<Response> elementos) async {
    await _responseInsertionAdapter.insertList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSingle(Response elemento) async {
    await _responseUpdateAdapter.update(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMultiple(List<Response> elementos) async {
    await _responseUpdateAdapter.updateList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSingle(Response elemento) async {
    await _responseDeletionAdapter.delete(elemento);
  }

  @override
  Future<void> deleteMultiple(List<Response> elementos) async {
    await _responseDeletionAdapter.deleteList(elementos);
  }
}

class _$VisitDao extends VisitDao {
  _$VisitDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _visitInsertionAdapter = InsertionAdapter(
            database,
            'Visit',
            (Visit item) => <String, Object?>{
                  'id': item.id,
                  'idProyecto': item.idProyecto,
                  'idSalidaTerreno': item.idSalidaTerreno,
                  'dirContacto': item.dirContacto,
                  'emailContacto': item.emailContacto,
                  'incluyeEvaluacion': item.incluyeEvaluacion ? 1 : 0,
                  'nombreBeneficiario': item.nombreBeneficiario,
                  'nombreProyecto': item.nombreProyecto,
                  'nombreInstrumento': item.nombreInstrumento,
                  'telefonoContacto': item.telefonoContacto,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'guardado': item.guardado ? 1 : 0
                }),
        _visitUpdateAdapter = UpdateAdapter(
            database,
            'Visit',
            ['id'],
            (Visit item) => <String, Object?>{
                  'id': item.id,
                  'idProyecto': item.idProyecto,
                  'idSalidaTerreno': item.idSalidaTerreno,
                  'dirContacto': item.dirContacto,
                  'emailContacto': item.emailContacto,
                  'incluyeEvaluacion': item.incluyeEvaluacion ? 1 : 0,
                  'nombreBeneficiario': item.nombreBeneficiario,
                  'nombreProyecto': item.nombreProyecto,
                  'nombreInstrumento': item.nombreInstrumento,
                  'telefonoContacto': item.telefonoContacto,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'guardado': item.guardado ? 1 : 0
                }),
        _visitDeletionAdapter = DeletionAdapter(
            database,
            'Visit',
            ['id'],
            (Visit item) => <String, Object?>{
                  'id': item.id,
                  'idProyecto': item.idProyecto,
                  'idSalidaTerreno': item.idSalidaTerreno,
                  'dirContacto': item.dirContacto,
                  'emailContacto': item.emailContacto,
                  'incluyeEvaluacion': item.incluyeEvaluacion ? 1 : 0,
                  'nombreBeneficiario': item.nombreBeneficiario,
                  'nombreProyecto': item.nombreProyecto,
                  'nombreInstrumento': item.nombreInstrumento,
                  'telefonoContacto': item.telefonoContacto,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'guardado': item.guardado ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Visit> _visitInsertionAdapter;

  final UpdateAdapter<Visit> _visitUpdateAdapter;

  final DeletionAdapter<Visit> _visitDeletionAdapter;

  @override
  Future<List<Visit>> findEverything() async {
    return _queryAdapter.queryList('SELECT * FROM Visit',
        mapper: (Map<String, Object?> row) => Visit(
            id: row['id'] as int?,
            dirContacto: row['dirContacto'] as String,
            emailContacto: row['emailContacto'] as String,
            idProyecto: row['idProyecto'] as int,
            idSalidaTerreno: row['idSalidaTerreno'] as int,
            incluyeEvaluacion: (row['incluyeEvaluacion'] as int) != 0,
            nombreBeneficiario: row['nombreBeneficiario'] as String,
            nombreInstrumento: row['nombreInstrumento'] as String,
            nombreProyecto: row['nombreProyecto'] as String,
            telefonoContacto: row['telefonoContacto'] as String,
            latitud: row['latitud'] as double,
            longitud: row['longitud'] as double,
            guardado: (row['guardado'] as int) != 0));
  }

  @override
  Future<List<Visit>> findSaved() async {
    return _queryAdapter.queryList('SELECT * FROM Visit WHERE guardado = 1',
        mapper: (Map<String, Object?> row) => Visit(
            id: row['id'] as int?,
            dirContacto: row['dirContacto'] as String,
            emailContacto: row['emailContacto'] as String,
            idProyecto: row['idProyecto'] as int,
            idSalidaTerreno: row['idSalidaTerreno'] as int,
            incluyeEvaluacion: (row['incluyeEvaluacion'] as int) != 0,
            nombreBeneficiario: row['nombreBeneficiario'] as String,
            nombreInstrumento: row['nombreInstrumento'] as String,
            nombreProyecto: row['nombreProyecto'] as String,
            telefonoContacto: row['telefonoContacto'] as String,
            latitud: row['latitud'] as double,
            longitud: row['longitud'] as double,
            guardado: (row['guardado'] as int) != 0));
  }

  @override
  Future<void> insertSingle(Visit elemento) async {
    await _visitInsertionAdapter.insert(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultiple(List<Visit> elementos) async {
    await _visitInsertionAdapter.insertList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSingle(Visit elemento) async {
    await _visitUpdateAdapter.update(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMultiple(List<Visit> elementos) async {
    await _visitUpdateAdapter.updateList(elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSingle(Visit elemento) async {
    await _visitDeletionAdapter.delete(elemento);
  }

  @override
  Future<void> deleteMultiple(List<Visit> elementos) async {
    await _visitDeletionAdapter.deleteList(elementos);
  }
}

class _$AttachmentDao extends AttachmentDao {
  _$AttachmentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _attachmentInsertionAdapter = InsertionAdapter(
            database,
            'Attachment',
            (Attachment item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idEvaluation': item.idEvaluation,
                  'type': item.type,
                  'binaryFile': item.binaryFile
                }),
        _attachmentUpdateAdapter = UpdateAdapter(
            database,
            'Attachment',
            ['id'],
            (Attachment item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idEvaluation': item.idEvaluation,
                  'type': item.type,
                  'binaryFile': item.binaryFile
                }),
        _attachmentDeletionAdapter = DeletionAdapter(
            database,
            'Attachment',
            ['id'],
            (Attachment item) => <String, Object?>{
                  'id': item.id,
                  'idVisita': item.idVisita,
                  'idEvaluation': item.idEvaluation,
                  'type': item.type,
                  'binaryFile': item.binaryFile
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Attachment> _attachmentInsertionAdapter;

  final UpdateAdapter<Attachment> _attachmentUpdateAdapter;

  final DeletionAdapter<Attachment> _attachmentDeletionAdapter;

  @override
  Future<List<Attachment>> findAttachmentsByVisitId(int idVisita) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Attachment WHERE idVisita = ?1',
        mapper: (Map<String, Object?> row) => Attachment(
            id: row['id'] as int?,
            idVisita: row['idVisita'] as int,
            idEvaluation: row['idEvaluation'] as int,
            type: row['type'] as String,
            binaryFile: row['binaryFile'] as String),
        arguments: [idVisita]);
  }

  @override
  Future<Attachment?> findAttachmentsByEvaluationId(
      int idVisita, int idEvaluation, String type) async {
    return _queryAdapter.query(
        'SELECT * FROM Attachment WHERE idVisita = ?1 AND idEvaluation = ?2 AND type = ?3 LIMIT 1',
        mapper: (Map<String, Object?> row) => Attachment(id: row['id'] as int?, idVisita: row['idVisita'] as int, idEvaluation: row['idEvaluation'] as int, type: row['type'] as String, binaryFile: row['binaryFile'] as String),
        arguments: [idVisita, idEvaluation, type]);
  }

  @override
  Future<Attachment?> findAttachmentsByEvaluationIdAndType(
      int idVisita, int idEvaluation, String type) async {
    return _queryAdapter.query(
        'SELECT * FROM Attachment WHERE idVisita = ?1 AND idEvaluation = ?2 AND type = ?3 LIMIT 1',
        mapper: (Map<String, Object?> row) => Attachment(id: row['id'] as int?, idVisita: row['idVisita'] as int, idEvaluation: row['idEvaluation'] as int, type: row['type'] as String, binaryFile: row['binaryFile'] as String),
        arguments: [idVisita, idEvaluation, type]);
  }

  @override
  Future<void> insertSingle(Attachment elemento) async {
    await _attachmentInsertionAdapter.insert(
        elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultiple(List<Attachment> elementos) async {
    await _attachmentInsertionAdapter.insertList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSingle(Attachment elemento) async {
    await _attachmentUpdateAdapter.update(elemento, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMultiple(List<Attachment> elementos) async {
    await _attachmentUpdateAdapter.updateList(
        elementos, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSingle(Attachment elemento) async {
    await _attachmentDeletionAdapter.delete(elemento);
  }

  @override
  Future<void> deleteMultiple(List<Attachment> elementos) async {
    await _attachmentDeletionAdapter.deleteList(elementos);
  }
}
