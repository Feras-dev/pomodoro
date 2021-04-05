// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    name: json['name'] as String,
    breakDuration: json['breakDuration'] as int,
    workDuration: json['workDuration'] as int,
  )
    ..id = json['id'] as int
    ..isComplete = json['isComplete'] as bool;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'workDuration': instance.workDuration,
      'breakDuration': instance.breakDuration,
      'isComplete': instance.isComplete,
    };
