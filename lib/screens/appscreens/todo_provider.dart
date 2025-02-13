import 'package:flutter/material.dart';

class TodoItems {
  final String id;
  String task;
  String description;
  String category;
  int priority;
  String dueDate;
  String dueTime;
  Color color;
  TodoItems(
      {String? id,
      required this.task,
      required this.description,
      required this.category,
      required this.priority,
      required this.dueDate,
      required this.dueTime,
      required this.color})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  String get gettitle => task;
  String get getdescription => description;
  String get getdate => dueDate;
  String get gettime => dueTime;
  String get getCategory => category;
  String get getpriority => priority.toString();
  Color get getcolor => color;
}

class Todoprovider with ChangeNotifier {
  List<TodoItems> todos = [];

  List<TodoItems> get todo => todos;
  void addTodo(TodoItems todo) {
    todos.add(todo);
    sortTasksByPriority();
    notifyListeners();
  }

  void updateTodo(TodoItems updatedTask) {
    int index = todo.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      todo[index] = updatedTask; // Replace the old task
      sortTasksByPriority();
      notifyListeners(); // Notify UI of changes
    }
  }

  int taskslength() {
    return todos.length;
  }

  void deleteTodo(TodoItems todo) {
    todos.remove(todo);
    sortTasksByPriority();
    notifyListeners();
  }

  void sortTasksByPriority() {
    todos.sort((a, b) => a.priority.compareTo(b.priority));
  }
}
