import 'package:flutter/material.dart';
//import 'package:todoapp_08/models/todo_model.dart';
import 'package:todoapp_08/helpers/todo_db.dart';
import 'package:todoapp_08/pages/list_pages.dart';
import 'package:todoapp_08/pages/save_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TodoDb todoDb = TodoDb();
  await todoDb.initDB();
  await todoDb.database;
  //todoDb.insert(Todo('esteban ', 'prueba alisson', 'por alisson', 1));
  /*final List<Todo> todos = await todoDb.getAll();

  final result = await todoDb.findById(2);

  if (result != null) {
    print(
        "${result.id} ${result.name} ${result.description} ${result.completeBy} ${result.priority}");
  } else {
    print("no resultados");
  }*/
  /*todos.forEach((element) {
    print(
        "${element.id} ${element.name} ${element.description} ${element.completeBy} ${element.priority}");
  });*/
  //todos[0].name = "alisson cambio";

  //todoDb.delete(todos[0]);
  //todoDb.update(todos[0]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE: ((context) => ListPage()),
        SavePage.ROUTE: ((context) => SavePage()),
      },
    );
  }
}
