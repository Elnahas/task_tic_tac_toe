part of 'task_list_cubit.dart';

sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}
final class TaskListUpdateLoading extends TaskListState {}
final class TaskListUpdated extends TaskListState {}

final class TaskListSuccess extends TaskListState {
  final List<TaskModel> listTask;

  TaskListSuccess(this.listTask);
}

final class TaskListNoResultsFound extends TaskListState {
    final String status;
  TaskListNoResultsFound(this.status);
}

final class TaskListFailure extends TaskListState {
  final String error;
  TaskListFailure(this.error);
}
