import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'Task.dart';

// A singleton class to access the storage.
// https://dart.academy/creational-design-patterns-for-dart-and-flutter-singleton/
class Storage {
  // Private _instance variable to store the
  // instance of this class.
  static Storage _instance;
  static SharedPreferences prefs;
  static const String TASK_LIST = "TASK_LIST";

  // Named constructor to be called
  // to store the instance of this class.
  Storage._internal() {
    _instance = this;
  }

  // The factory constructor creates a new instance just once,
  // then it returns that cached instance on every future invocation.
  factory Storage() => _instance ?? Storage._internal();

  // Whenever this class is instantiated, this will
  // create a new SharedPreferences instance to be used.
  Future<SharedPreferences> enableStorage() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  // CRUD
  // All below methods will use SharedPreferences
  // instance created above.

  // Add task method to add a single task to storage.
  Future<bool> addTask(Task task) async {
    // Get a list which is already stored in SP (SharedPreferences).
    List<String> result = prefs.getStringList(TASK_LIST);
    List<Task> taskList;

    if (result != null)
      // If the list obtained from storage contains previously
      // stored tasks, we need to append current task to that list
      // of tasks. Here, we are converting all the JSON data from `result`
      // into a `List<Task>` using decode method.
      taskList = result.map((t) => Task.fromJson(json.decode(t))).toList();
    else
      // Otherwise, just create a new empty list.
      taskList = [];
    taskList.add(task);

    // Encode the modified list into JSON again to store.
    List<String> myList =
        taskList.map((task) => json.encode(task.toJson())).toList();

    // DEBUG:
    // print(myList);
    return prefs.setStringList(TASK_LIST, myList);
  }

  // Delete task method to delete task from the task list and update storage
  // with the modified list
  Future<bool> deleteTask(Task taskDel) async {
    // Get a list which is already stored in SP (SharedPreferences).
    List<String> result = prefs.getStringList(TASK_LIST);
    List<Task> taskList;

    if (result != null)
      // If the list obtained from storage contains previously
      // stored tasks, we need to append current task to that list
      // of tasks. Here, we are converting all the JSON data from `result`
      // into a `List<Task>` using decode method.
      taskList = result.map((t) => Task.fromJson(json.decode(t))).toList();
    else
      // Otherwise, just create a new empty list.
      taskList = [];
    // Remove the selected item from the task list by matching the
    // task name. taskDel is the task to be deleted and element is the
    // matched element during the traversal of list
    taskList.removeWhere((element) => (element.id == taskDel.id));

    // Encode the modified list into JSON again to store.
    List<String> myList =
        taskList.map((task) => json.encode(task.toJson())).toList();

    // DEBUG:
    // print(myList);
    return prefs.setStringList(TASK_LIST, myList);
  }

  // Update task method to update task from the task list and update storage
  // with the modified list
  Future<bool> updateTask(Task oldTask, Task newTask) async {
    // Get a list which is already stored in SP (SharedPreferences).
    List<String> result = prefs.getStringList(TASK_LIST);
    List<Task> taskList;

    if (result != null)
      // If the list obtained from storage contains previously
      // stored tasks, we need to append current task to that list
      // of tasks. Here, we are converting all the JSON data from `result`
      // into a `List<Task>` using decode method.
      taskList = result.map((t) => Task.fromJson(json.decode(t))).toList();
    else
      // Otherwise, just create a new empty list.
      taskList = [];
    // Remove the selected item from the task list by matching the
    // task name. taskDel is the task to be deleted and element is the
    // matched element during the traversal of list
    taskList.removeWhere((element) => (element.id == oldTask.id));
    taskList.add(newTask);

    // Encode the modified list into JSON again to store.
    List<String> myList =
        taskList.map((task) => json.encode(task.toJson())).toList();

    // DEBUG:
    // print(myList);
    return prefs.setStringList(TASK_LIST, myList);
  }

  List<Task> getTasks() {
    List<String> result = prefs.getStringList(TASK_LIST);
    List<Task> tasks = [];
    if (result != null) {
      tasks = result.map((t) => Task.fromJson(json.decode(t))).toList();
      tasks.sort(
          (a, b) => (a.priorityLevel.index).compareTo(b.priorityLevel.index));
    }
    return tasks;
  }

  // For debugging
  void removeAllTasks() async {
    await prefs.clear();
  }
}