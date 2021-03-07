import 'dart:async';

import 'package:path/path.dart';
import 'package:pomodoro/Task.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static const name = 'pomodoro_database';

  static Future<Database> init() async {
    final Future<Database> database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'pomodoro_database.db'),
        onCreate: (db, version) {
      return db.execute('''CREATE TABLE(id INTEGER PRIMARY KEY, 
                name TEXT,
                isComplete BOOLEAN,
                workDuration INTEGER,
                breakDuration INTEGER''');
    }, version: 1);
    return database;
  }

  static Future<int> addTask(Task task) async {
    final db = await init();
    return db.insert(name, task.toMap());
  }
}
