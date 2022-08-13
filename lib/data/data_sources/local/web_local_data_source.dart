import 'package:e2e_application/data/data_sources/local/database/indexed_database_provider.dart';
import 'package:e2e_application/data/data_sources/local/user_local_data_source.dart';
import 'package:e2e_application/data/models/user_model.dart';
import 'package:sembast/sembast.dart';


class  WebLocalDataSource implements UserLocalDataSource{

  final IndexedDatabaseProvider dbProvider;

  WebLocalDataSource({required this.dbProvider});


  @override
  Future<void> closeDatabase() async => await dbProvider.close();

  @override
  Future<int> createUser(UserModel user) async{
    final store = dbProvider.store;
    await store.add(await dbProvider.database, user.toJson());
    return 1;
  }

  @override
  Future<int> deleteAllUsers() async{
    final store = dbProvider.store;

    final numOfRecordEffected = await store.delete(await dbProvider.database);
    return numOfRecordEffected;
  }

  @override
  Future<int> deleteUser(int id) async{
    final store = dbProvider.store;

    final key = await store.record(id).delete(await dbProvider.database);
    return key != null? 1 : 0;
  }

  @override
  Future<UserModel?> getUser({required int id}) async{
    final store = dbProvider.store;

    final finder = Finder(filter: Filter.byKey(id));
    var result = await store.find(await dbProvider.database, finder: finder,);

    if (result.isEmpty) return null;


    List<UserModel> users = result.map((snapShot) => UserModel.fromMap(
        snapShot.key,snapShot.value)).toList();

    UserModel? user = users[0];

    return user;
  }

  @override
  Future<List<UserModel>> getUsers({String? query}) async{
    final store = dbProvider.store;

    var result = await store.find(await dbProvider.database,
      finder: query != null&&query.isNotEmpty
          ? Finder(
          filter:containsMapFilter({dbProvider.columnName: query})):null
        );


    if (result.isEmpty) return [];
    List<UserModel> users = result.map((snapShot) => UserModel.fromMap(
        snapShot.key,snapShot.value
    )).toList();

    return users;
  }


  @override
  Future<int> updateUser(UserModel user) async{
    final store = dbProvider.store;

    if(user.id == null) return 0;
    await store.record(user.id!).put(
        await dbProvider.database,
        user.toJson(),
    );

    return 1;
  }

  Filter containsMapFilter(Map<String, Object?> map) {
    return Filter.and(
        map.entries.map((e) => Filter.equals(e.key, e.value)).toList());
  }

}