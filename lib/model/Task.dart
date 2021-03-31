import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$TaskFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TaskToJson`.
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
