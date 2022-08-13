import 'package:e2e_application/data/data_sources/local/database/sql_database_provider.dart';
import 'package:e2e_application/data/data_sources/local/user_local_data_source.dart';
import 'package:e2e_application/data/models/user_model.dart';

class AppLocalDataSource implements UserLocalDataSource {
  final SQLDatabaseProvider dbProvider;

  AppLocalDataSource({required this.dbProvider});

  @override
  Future<int> createUser(UserModel user) async {
    final db = await dbProvider.database;

    var result = await db.insert(dbProvider.userTable, user.toJson());

    return result;
  }

  @override
  Future<int> deleteAllUsers() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      dbProvider.userTable,
      where: null,
    );
    return result;
  }

  @override
  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;

    var result = await db.delete(dbProvider.userTable,
        where: '${dbProvider.columnId} = ?', whereArgs: [id]);

    return result;
  }

  @override
  Future<UserModel?> getUser({required int id}) async {
    final db = await dbProvider.database;

    var result = await db.query(dbProvider.userTable,
        columns: <String>[
          dbProvider.columnId,
          dbProvider.columnName,
          dbProvider.columnUsername,
          dbProvider.columnEmail
        ],
        where: '${dbProvider.columnId} = ?',
        whereArgs: [id]);

    if (result.isEmpty) return null;
    List<UserModel> users =
        result.map((user) => UserModel.fromJson(user)).toList();
    UserModel? user = users[0];

    return user;
  }

  @override
  Future<List<UserModel>> getUsers(
      {String? query}) async {
    final db = await dbProvider.database;
    final columns =  <String>[
      dbProvider.columnId,
      dbProvider.columnName,
      dbProvider.columnUsername,
      dbProvider.columnEmail
    ];

    List<Map<String, dynamic>> result;
    if (query != null && query.isNotEmpty) {
      result = await db.query(dbProvider.userTable,
          columns: columns, where: '${dbProvider.columnName} LIKE ?', whereArgs: ['%$query%']);
    } else {
      result = await db.query(dbProvider.userTable, columns: columns);
    }

    List<UserModel> users = result.isNotEmpty
        ? result.map((user) => UserModel.fromJson(user)).toList()
        : [];
    return users;
  }

  @override
  Future<int> updateUser(UserModel user) async {
    final db = await dbProvider.database;

    var result = await db.update(dbProvider.userTable, user.toJson(),
        where: '${dbProvider.columnId} = ?', whereArgs: [user.id]);

    return result;
  }

  @override
  Future<void> closeDatabase() => dbProvider.close();
}
