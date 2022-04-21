// ignore_for_file: avoid_print

import 'dart:async';

import 'package:todoapp_08/helpers/todo_db.dart';
import 'package:todoapp_08/models/todo_model.dart';

class TodosBloc {
  static final TodosBloc _singleton = TodosBloc._internal();

  late TodoDb db;
  late List<Todo> todosList = [];

  //obatener los datos
  final _todosStreamController = StreamController<List<Todo>>.broadcast();

  //cambiar o manipular los datos
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  //stream obtener datos
  Stream<List<Todo>> get todosStream => _todosStreamController.stream;
  StreamSink<List<Todo>> get todosAllSink => _todosStreamController.sink;

  // sink envia o agrega datos
  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;
  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;
  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  factory TodosBloc() {
    return _singleton;
  }

  TodosBloc._internal() {
    db = TodoDb();
    getAll();

    _todosStreamController.stream.listen(returnAll);
    _todoInsertController.stream.listen(insert);
    _todoUpdateController.stream.listen(update);
    _todoDeleteController.stream.listen(delete);
  }
/*
  TodosBloc() {
    db = TodoDb();
    getAll();

    _todosStreamController.stream.listen(returnAll);
    _todoInsertController.stream.listen(insert);
    _todoUpdateController.stream.listen(update);
    _todoDeleteController.stream.listen(delete);
  }*/

  Future getAll() async {
    List<Todo> todos = await db.getAll();
    todosList = todos;
    todosAllSink.add(todos);
  }

  List<Todo> returnAll(todos) {
    return todos;
  }

  void delete(Todo todo) {
    db.delete(todo).then((_) => getAll());
  }

  void update(Todo todo) {
    db.update(todo).then((_) => getAll());
  }

  void insert(Todo todo) {
    db.insert(todo).then((_) => getAll());
  }

  void dispose() {
    _todosStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
