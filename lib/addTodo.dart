import 'package:flutter/material.dart';
import 'package:flutter_class_todolist/ShareData.dart';

void addTodo(BuildContext context) {
  TextEditingController name = TextEditingController();
  TextEditingController tags = TextEditingController();

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
                  "New Todo",
                  style: titleStyle,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: tags,
                  decoration:
                      const InputDecoration(hintText: "Tags (spec with space)"),
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
                        TodoData().newTodo(
                          Todo(
                              name: name.text,
                              isDone: false,
                              tags: tag[0] == "" ? [] : tag,
                              createdAt: DateTime.now().millisecondsSinceEpoch),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text("Add"),
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
