import 'package:flutter/material.dart';
import 'package:flutter_class_todolist/EditTodo.dart';
import 'package:flutter_class_todolist/ShareData.dart';

Widget todoItemBuilder(
        Todo it, int index, bool isProxy, BuildContext context) =>
    Container(
      key: ValueKey(it.createdAt),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: ValueKey(it.createdAt),
          confirmDismiss: (dir) async {
            if (dir == DismissDirection.endToStart) {
              editTodo(context, index);
              return false;
            }
            return true;
          },
          onDismissed: (dir) {
            TodoData().removeTodo(index);
          },
          background: Container(
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 5),
                  Text("Delete Todo")
                ],
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Edit Todo"),
                  SizedBox(width: 5),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        it.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8,
                        runSpacing: 7,
                        children: it.tags
                            .asMap()
                            .entries
                            .map((entry) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromRGBO(
                                      200, 100, (entry.key * 50) % 255, 0.6),
                                ),
                                child: Text(entry.value)))
                            .toList(),
                      )
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Checkbox(
                      value: it.isDone,
                      onChanged: (newValue) {
                        TodoData().toggleDone(index);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
