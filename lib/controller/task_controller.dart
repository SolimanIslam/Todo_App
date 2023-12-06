import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo_list/controller/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// class TasksController extends ChangeNotifier {
//   final List<Task> _tasks = [
//     Task(taskName: "Go to Gym"),
//     Task(taskName: 'Study'),
//     Task(taskName: 'Prepare you Meals'),
//     Task(taskName: "Go to Gym"),
//     Task(taskName: 'Study'),
//     Task(taskName: 'Prepare you Meals'),
//     Task(taskName: "Go to Gym"),
//     Task(taskName: 'Study'),
//     Task(taskName: 'Prepare you Meals'),
//     Task(taskName: 'Prepare you Meals'),
//     Task(taskName: "Go to Gym"),
//     Task(taskName: 'Study'),
//     Task(taskName: 'Prepare you Meals'),
//   ];
//
//   UnmodifiableListView<Task> get getTasks {
//     return UnmodifiableListView(_tasks);
//   }
//
//   int get numberOfTasks {
//     return _tasks.length;
//   }
//
//   void addTask(String taskName) {
//     Task task = Task(taskName: taskName);
//     _tasks.add(task);
//     notifyListeners();
//   }
//
//   void removeTask(Task task) {
//     _tasks.remove(task);
//     notifyListeners();
//   }
//
//   void toggleTask(Task task) {
//     task.toggleTask();
//     notifyListeners();
//   }
//
//   void clearTodoList() {
//     _tasks.clear();
//     notifyListeners();
//   }
// }
//
// class TasksController extends ChangeNotifier {
//   final List<Task> _tasks = [
//     Task(taskName: "Go to Gym"),
//     Task(taskName: 'Study'),
//     Task(taskName: 'Prepare you Meals')
//   ];
//
//   UnmodifiableListView<Task> get getTasks {
//     return UnmodifiableListView(_tasks);
//   }
//
//   int get numberOfTasks {
//     return _tasks.length;
//   }
//
//   void addTask(String taskName) {
//     Task task = Task(taskName: taskName);
//     _tasks.add(task);
//     notifyListeners();
//   }
//
//   void removeTask(Task task) {
//     _tasks.remove(task);
//     notifyListeners();
//   }
//
//   void toggleTask(Task task) {
//     task.toggleTask();
//     notifyListeners();
//   }
//
//   void clearTodoList() {
//     _tasks.clear();
//     notifyListeners();
//   }
// }
// //
class TasksController extends ChangeNotifier {
  List<Task> _tasks = [];

  List<String> stringJsonTaskList() {
    return _tasks.map((task) => jsonEncode(task.toJson())).toList();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', stringJsonTaskList());
  }

  void taskList(List<String>? sharedPrefTasks) {
    if (sharedPrefTasks == null || sharedPrefTasks.isEmpty) {
      _tasks.clear();
      // _tasks = [];
    } else {
      // _tasks = sharedPrefTasks
      //     .map((encodedTask) => (Task.fromJson(jsonDecode(encodedTask))))
      //     .toList();
      _tasks
        ..clear()
        ..addAll(sharedPrefTasks
            .map((encodedTask) => (Task.fromJson(jsonDecode(encodedTask))))
            .toList());
    }
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final sharedPrefTasks = prefs.getStringList('tasks');
    taskList(sharedPrefTasks!);
  }

  UnmodifiableListView<Task> get getTasks => UnmodifiableListView(_tasks);

  int get numberOfTasks => _tasks.length;

  void addTask(String taskName) {
    Task task = Task(taskName: taskName);
    _tasks.add(task);
    notifyListeners();
    _saveTasks();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    _saveTasks();
  }

  void toggleTask(Task task) {
    task.toggleTask();
    notifyListeners();
    _saveTasks();
  }

  void clearTodoList() {
    _tasks.clear();
    notifyListeners();
    _saveTasks();
  }

  TasksController() {
    print(_tasks);
    _loadTasks();
  }
}
