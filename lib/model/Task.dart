import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PriorityLevel.dart';

part 'Task.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Task {
  String id;
  String name;
  int workDuration;
  int breakDuration;
  bool isComplete;
  PriorityLevel priorityLevel;

  Task(
      {@required this.id,
      @required this.name,
      @required this.breakDuration,
      @required this.workDuration,
      @required this.priorityLevel,
      @required this.isComplete});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$TaskFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TaskToJson`.
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
