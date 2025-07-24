import 'package:flutter/material.dart';
import 'package:flutter_class_todolist/ShareData.dart';

void editTodo(BuildContext context, int index) {
  var targetTodo = TodoData().todos[index];
  TextEditingController name = TextEditingController();
  TextEditingController tags = TextEditingController();
  name.text = targetTodo.name;
  tags.text = targetTodo.tags.join(" ");

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                sheetTop,
                Text(
                  "Edit Todo",
                  style: titleStyle,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: InputDecoration(hintText: targetTodo.name),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: tags,
                  decoration:
                      InputDecoration(hintText: targetTodo.tags.join(" ")),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: View.of(context).viewPadding.bottom),
                    child: FilledButton(
                      onPressed: () {
                        List<String> tag = tags.text.split(" ");
                        TodoData().updateTodo(
                          index,
                          Todo(
                              name: name.text,
                              isDone: targetTodo.isDone,
                              tags: tag[0] == "" ? [] : tag,
                              createdAt: targetTodo.createdAt),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text("Edit"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
