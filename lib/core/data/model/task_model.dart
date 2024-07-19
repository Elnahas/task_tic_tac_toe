import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../helpers/json_helpers.dart';
import '../enum/task_status.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String id;
  final String title;
  @JsonKey(fromJson: TaskStatusExtension.fromString, toJson: _taskStatusToJson)
  final TaskStatus status;
  @JsonKey(
      name: 'due_time', fromJson: timestampFromJson, toJson: timestampToJson)
  final Timestamp dueTime;

  TaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.dueTime,
  });

  static String _taskStatusToJson(TaskStatus taskStatus) =>
      taskStatus.toShortString();
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
