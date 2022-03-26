import 'package:bbigfood/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String databaseName = 'bbig.db';
  final String tableDatabase = 'foodtable';
  final String columnId = 'id';
  final String columnIdSeller = 'idSeller';
  final String columnNameSeller = 'nameSeller';
  final String columnIdMenu = 'idMenu';
  final String columnNamemenu = 'nameMenu';
  final String columnPrice = 'price';
  final String columnAmount = 'amount';
  final String columnSum = 'sum';
  final int version = 1;

  SQLiteHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDatabase (id INTEGER PRIMARY KEY, $columnIdSeller TEXT, $columnNameSeller TEXT, $columnIdMenu TEXT, $columnNamemenu TEXT, $columnPrice TEXT, $columnAmount TEXT, $columnSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName));
  }

  Future<void> insertData(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();
    await database
        .insert(
          tableDatabase,
          sqLiteModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => print('insertData Success'));
  }

  Future<List<SQLiteModel>> readData() async {
    var sqliteModels = <SQLiteModel>[];

    Database database = await connectedDatabase();
    var result = await database.query(tableDatabase);
    for (var item in result) {
      SQLiteModel sqLiteModel = SQLiteModel.fromMap(item);
      sqliteModels.add(sqLiteModel);
    }

    return sqliteModels;
  }

  Future<void> deleteWhereId(int indexDelete) async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase, where: '$columnId = $indexDelete');
  }

  Future<void> clearDatabase() async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase);
  }
}
