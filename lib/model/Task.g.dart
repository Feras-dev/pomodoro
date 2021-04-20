// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as String,
    name: json['name'] as String,
    breakDuration: json['breakDuration'] as int,
    workDuration: json['workDuration'] as int,
    priorityLevel:
        _$enumDecodeNullable(_$PriorityLevelEnumMap, json['priorityLevel']),
    isComplete: json['isComplete'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'workDuration': instance.workDuration,
      'breakDuration': instance.breakDuration,
      'isComplete': instance.isComplete,
      'priorityLevel': _$PriorityLevelEnumMap[instance.priorityLevel],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PriorityLevelEnumMap = {
  PriorityLevel.LOW: 'low',
  PriorityLevel.MEDIUM: 'medium',
  PriorityLevel.HIGH: 'high',
  PriorityLevel.VERY_HIGH: 'very_high',
  PriorityLevel.CRITICAL: 'critical',
};
