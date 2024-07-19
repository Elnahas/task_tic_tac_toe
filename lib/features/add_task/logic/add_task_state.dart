part of 'add_task_cubit.dart';

sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskLoading extends AddTaskState {}
final class AddTaskSuccess extends AddTaskState {}
final class AddTaskFailure extends AddTaskState {
  final String error;
  AddTaskFailure(this.error);
}

