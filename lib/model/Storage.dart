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

  // Named constructor to be called
  // to store the instance of this class.
  Storage._internal() {
    _instance = this;
    enableStorage();
  }

  // The factory constructor creates a new instance just once,
  // then it returns that cached instance on every future invocation.
  factory Storage() => _instance ?? Storage._internal();

  // Whenever this class is instantiated, this will
  // create a new SharedPreferences instance to be used.
  void enableStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  // All below methods will use SharedPreferences
  // instance created above.
  bool storeTask(Task task) {
    print(jsonEncode(task));
  }
}