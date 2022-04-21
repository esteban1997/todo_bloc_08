// ignore_for_file: prefer_conditional_assignment

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:todoapp_08/models/todo_model.dart';

class TodoDb {
  static late Database _database;
  final store = intMapStoreFactory.store('todos'); //tabla carpeta

  initDB() async {
    final docsPath = await getApplicationDocumentsDirectory();
    _database = await databaseFactoryIo
        .openDatabase(join(docsPath.path, 'todoapp', 'sembast', 'todos.db'));
  }

//<   >
  Future<Database> get database async {
    return _database;
  }

  Future insert(Todo todo) async {
    await store.add(_database, todo.toMap());
  }

  Future<List<Todo>> getAll() async {
    final finder = Finder(sortOrders: [SortOrder('priority')]);
    final todosSnapshot = await store.find(_database, finder: finder);

    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  Future<Todo?> findById(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await store.findFirst(_database, finder: finder);
    if (snapshot != null) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }
    return null;
  }

  Future delete(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database, finder: finder);
  }

  Future update(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database, todo.toMap(), finder: finder);
  }
}
