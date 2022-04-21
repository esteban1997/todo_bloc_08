// ignore_for_file: prefer_const_constructors, constant_identifier_names, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:todoapp_08/models/todo_model.dart';
import 'package:todoapp_08/pages/list_pages.dart';
import 'package:todoapp_08/todos_bloc.dart';
import 'package:todoapp_08/widget/custom_text_field.dart';

class SavePage extends StatelessWidget {
  static const String ROUTE = "/save";
  final TextEditingController nameEditingControler = TextEditingController();
  final TextEditingController descriptionEditingControler =
      TextEditingController();
  final TextEditingController completeEditingControler =
      TextEditingController();
  final TextEditingController priorityEditingControler =
      TextEditingController();

  final TodosBloc todosBloc = TodosBloc();

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context)!.settings.arguments == null
        ? Todo.empty()
        : ModalRoute.of(context)!.settings.arguments as Todo;

    if (todo.id != 0) {
      nameEditingControler.text = todo.name;
      descriptionEditingControler.text = todo.description;
      completeEditingControler.text = todo.completeBy;
      priorityEditingControler.text = todo.priority.toString();
    }

    return Scaffold(
      appBar: AppBar(title: Text(todo.id == 0 ? "Create todo" : "Save todo")),
      body: Card(
          child: Column(
        children: [
          CumtomTextField(
            placeholder: "Nombre",
            icon: Icons.list,
            controller: nameEditingControler,
          ),
          SizedBox(height: 15),
          CumtomTextField(
            placeholder: "Descripcion",
            icon: Icons.description,
            controller: descriptionEditingControler,
          ),
          SizedBox(height: 15),
          CumtomTextField(
            placeholder: "Completado",
            icon: Icons.check,
            controller: completeEditingControler,
          ),
          SizedBox(height: 15),
          CumtomTextField(
            placeholder: "Prioridad",
            icon: Icons.star,
            controller: priorityEditingControler,
            tipoCampo: TextInputType.number,
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                //TODo actualizar

                todo.name = nameEditingControler.text;
                todo.description = descriptionEditingControler.text;
                todo.completeBy = completeEditingControler.text;
                try {
                  todo.priority = int.parse(priorityEditingControler.text);
                } catch (e) {
                  todo.priority = 1;
                }

                /*print(todo.id);
                print(todo.name);
                print(todo.description);
                print(todo.completeBy);
                print(todo.priority);*/

                if (todo.id == 0) {
                  todosBloc.todoInsertSink.add(todo);
                } else {
                  todosBloc.todoUpdateSink.add(todo);
                }

                /*Navigator.pushNamedAndRemoveUntil(
                    context, ListPage.ROUTE, (route) => false);*/
                Navigator.pop(context);
              },
              child: Text(todo.id == 0 ? "Guardar" : "Actualizar")),
        ],
      )),
    );
  }
}
