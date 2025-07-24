import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget sheetTop = Container(
  margin: const EdgeInsets.symmetric(vertical: 10),
  width: 100,
  height: 10,
  decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(100),
  ),
);

TextStyle titleStyle =
    const TextStyle(fontSize: 29, fontWeight: FontWeight.bold);

const channel_name =
    "dev.eliaschen.class_todolist.flutter_class_todolist/method";

class TodoData extends ChangeNotifier {
  static final TodoData _instance = TodoData._internal();

  factory TodoData() => _instance;

  TodoData._internal() {
    getData();
  }

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void writeData() {
    var jsonString = jsonEncode(_todos.map((item) => item.toJson()).toList());
    const MethodChannel(channel_name).invokeMethod("write", jsonString);
  }

  Future<void> getData() async {
    final jsonString = await MethodChannel(channel_name).invokeMethod("get");
    final List<dynamic> jsonMap = jsonDecode(jsonString);
    _todos.clear();
    _todos.addAll(jsonMap.map((item) => Todo.fromJson(item)).toList());
    notifyListeners();
  }

  void toggleDone(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
    writeData();
  }

  void newTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
    writeData();
  }

  void updateTodo(int index, Todo todo) {
    _todos[index] = todo;
    notifyListeners();
    writeData();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
    writeData();
  }

  void reorderTodo(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final temp = _todos.removeAt(oldIndex);
    _todos.insert(newIndex, temp);
    notifyListeners();
    writeData();
  }
}

class Todo {
  String name;
  bool isDone;
  List<String> tags;
  int createdAt;

  Todo(
      {required this.name,
      required this.isDone,
      required this.tags,
      required this.createdAt});

  factory Todo.fromJson(item) => Todo(
      name: item['name'],
      isDone: item['isDone'],
      tags: List<String>.from(item['tags']),
      createdAt: item['createdAt']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'isDone': isDone, 'tags': tags, 'createdAt': createdAt};
}
