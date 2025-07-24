import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_class_todolist/ShareData.dart';
import 'package:flutter_class_todolist/addTodo.dart';
import 'package:flutter_class_todolist/todoItem.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Entry(),
    ),
  );
}

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  void initState() {
    super.initState();
    TodoData();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      builder: (context, widget) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Todo List",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                        footer: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton.tonalIcon(
                                onPressed: () {
                                  addTodo(context);
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("New Todo"),
                              )
                            ],
                          ),
                        ),
                        proxyDecorator: (child, index, animation) {
                          final it = TodoData().todos[index];
                          return todoItemBuilder(it, index, true, context);
                        },
                        itemBuilder: (context, index) {
                          final it = TodoData().todos[index];
                          return todoItemBuilder(it, index, false, context);
                        },
                        itemCount: TodoData().todos.length,
                        onReorder: TodoData().reorderTodo),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listenable: TodoData(),
    );
  }
}
