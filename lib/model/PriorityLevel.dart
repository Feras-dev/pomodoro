import 'package:json_annotation/json_annotation.dart';

// Enum to control the values for
// Task Priority.
enum PriorityLevel {
  @JsonValue("low")
  LOW,
  @JsonValue("medium")
  MEDIUM,
  @JsonValue("high")
  HIGH,
  @JsonValue("very_high")
  VERY_HIGH,
  @JsonValue("critical")
  CRITICAL,
}