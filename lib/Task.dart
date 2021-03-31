import 'package:flutter/foundation.dart';

class Task {
  int id;
  String name;
  int workDuration;
  int breakDuration;
  bool isComplete;

  Task(
      {@required this.name,
      @required this.breakDuration,
      @required this.workDuration}) {
    this.id = DateTime.now().millisecondsSinceEpoch;
    this.isComplete = false;
  }

  Task.fromDb(
      {@required this.id,
      @required this.name,
      @required this.breakDuration,
      @required this.workDuration,
      @required this.isComplete});

  // Convert a Task into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'isComplete': isComplete
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task.fromDb(
        id: map['id'],
        name: map['name'],
        breakDuration: map['breakDuration'],
        workDuration: map['workDuration'],
        isComplete: map['isComplete']);
  }
}
