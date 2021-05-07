import 'package:json_annotation/json_annotation.dart';

// Enum to control the values for
// Task Priority.
enum PriorityLevel {
  @JsonValue("critical")
  CRITICAL,
  @JsonValue("very_high")
  VERY_HIGH,
  @JsonValue("high")
  HIGH,
  @JsonValue("medium")
  MEDIUM,
  @JsonValue("low")
  LOW,
}
