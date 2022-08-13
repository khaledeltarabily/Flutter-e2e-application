abstract class DatabaseProviderBase{
  final String dbName = 'Users.db';
  final int dbVersion = 1;

  final String userTable = 'Users';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnUsername = 'username';
  final String columnEmail = 'email';

  Future get database;
  Future<String> get dbPath;

  Future createDatabase(String path);

  Future open();

  Future<void> close();

}