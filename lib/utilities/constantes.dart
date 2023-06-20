import 'package:floor/floor.dart';
import 'package:fudea/data/database/database.dart';

class Constantes {
  static const String databaseName = 'peppery_database.db';
  static const int databaseVersion = 1;
  String url =
      'http://vps-2872295-x.dattaweb.com:9069/operaciones/app/visitas2/';


  Future<AppDatabase> databaseFuture() async {
    return await $FloorAppDatabase
        .databaseBuilder(databaseName).build();
  }

  Future<void> borrarBaseDeDatos() async {
    AppDatabase _database = await databaseFuture();
    await _database.clearAllTables();
  }

}
