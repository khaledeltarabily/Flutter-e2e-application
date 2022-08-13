
import 'dart:io';

import 'package:e2e_application/data/data_sources/local/database/database_provider_base.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLDatabaseProvider extends DatabaseProviderBase{

  Database? _database;

  static final SQLDatabaseProvider _sqlDB = SQLDatabaseProvider._internal();

  factory SQLDatabaseProvider() {
    return _sqlDB;
  }

  SQLDatabaseProvider._internal();

  @override
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await open();
    return _database!;
  }

  @override
  Future<Database> createDatabase(String path) async {
    var database = await openDatabase(path,
        version: dbVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future<void> initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $userTable ("
        "$columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT, "
        "$columnUsername TEXT, "
        "$columnEmail TEXT "
        ")");
  }

  @override
  Future<Database> open() async => await createDatabase(await dbPath);

  @override
  Future<void> close() async => _database?.close();

  @override
  Future<String> get dbPath async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, dbName);
  }
}
