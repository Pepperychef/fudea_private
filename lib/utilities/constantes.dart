import 'package:floor/floor.dart';
import 'package:fudea/data/database/database.dart';

class Constantes {
  static const String databaseName = 'alfaapp_database.db';
  static const int databaseVersion = 3;

  Future<AppDatabase> databaseFuture() async {
    return await $FloorAppDatabase
        .databaseBuilder(databaseName).build();
  }

  Future<void> borrarBaseDeDatos() async {
    AppDatabase _database = await databaseFuture();
    await _database.clearAllTables();
  }

}
