
import 'package:e2e_application/data/data_sources/local/database/database_provider_base.dart';
import 'package:sembast/sembast.dart';

class IndexedDatabaseProvider extends DatabaseProviderBase{

  final DatabaseFactory dbFactory;
  late final StoreRef store;

  Database? _database;

  IndexedDatabaseProvider(this.dbFactory){
    store = intMapStoreFactory.store(userTable);
  }


  @override
  Future<Database> createDatabase(String path) async {
    var database = await dbFactory.openDatabase(path,
        version: dbVersion, onVersionChanged: _onUpgrade);
    return database;
  }

  @override
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await open();
    return _database!;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {}
  }

  @override
  Future<Database> open() async => await createDatabase(await dbPath);

  @override
  Future<void> close() async => await _database?.close();

  Future<void> deleteDb() async => dbFactory.deleteDatabase(await dbPath);

  @override
  Future<String> get dbPath async => dbName;
}
