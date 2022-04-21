// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:todoapp_08/models/todo_model.dart';
import 'package:todoapp_08/pages/save_page.dart';
import 'package:todoapp_08/todos_bloc.dart';

class ListPage extends StatefulWidget {
  static const String ROUTE = "/";

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Todo> todos;
  late TodosBloc todosBloc;

  @override
  void initState() {
    todosBloc = TodosBloc();
    super.initState();
  }

  @override
  void dispose() {
    todosBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    todos = todosBloc.todosList;

    print("identical(todosBloc, TodosBloc())");
    print(identical(todosBloc, TodosBloc()));

    return Scaffold(
      appBar: AppBar(title: Text("titulo listado")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, SavePage.ROUTE);
          }),
      body: StreamBuilder(
        stream: todosBloc.todosStream,
        initialData: todos,
        builder: (_, AsyncSnapshot snapshot) {
          print("streambuilder");
          return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: (_, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (_) {
                    print("eliminado");
                    todosBloc.todoDeleteSink.add(snapshot.data[index]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: snapshot.data[index].priority > 5
                            ? Colors.red
                            : Colors.green,
                        child: Text("${snapshot.data[index].priority}")),
                    title: Text("${snapshot.data[index].name}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                    trailing: GestureDetector(child: Icon(Icons.edit)),
                    onTap: () {
                      Navigator.pushNamed(context, SavePage.ROUTE,
                          arguments: snapshot.data[index]);
                    },
                  ),
                );
              });
        },
      ), /*ListView(
        children: [
          ListTile(
            title: Text("componente 1"),
          ),
          ListTile(
            title: Text("componente 2"),
          ),
          ListTile(
            title: Text("componente 3"),
          ),
        ],
      ),*/
    );
  }
}
