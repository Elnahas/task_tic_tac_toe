// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: TaskStatusExtension.fromString(json['status'] as String),
      dueTime: timestampFromJson(json['due_time']),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': TaskModel._taskStatusToJson(instance.status),
      'due_time': timestampToJson(instance.dueTime),
    };
