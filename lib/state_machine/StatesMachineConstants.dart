import 'package:json_annotation/json_annotation.dart';

// Enum to control possible states for the application
// Task Priority.
enum State {
  @JsonValue("idle")
  IDLE,
  @JsonValue("work")
  WORK,
  @JsonValue("break")
  BREAK,
  @JsonValue("error")
  ERROR,
}
