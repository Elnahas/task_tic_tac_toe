part of 'task_list_cubit.dart';

sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}
final class TaskListUpdateLoading extends TaskListState {}
final class TaskListUpdated extends TaskListState {}
final class TaskListMovePlayer extends TaskListState {}

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


final class TaskListGameInProgress extends TaskListState {
  final List<List<String>> board;
  final String currentPlayer;

  TaskListGameInProgress({required this.board, required this.currentPlayer});
}

final class TaskListGameFinished extends TaskListState {
  final String winner;
  final String taskId;

  TaskListGameFinished(this.taskId, {required this.winner});



}



final class TaskListUpdateTimeLeft extends TaskListState {
  final int minutesLeft;
  final int secondsLeft;
  final String taskId;

  TaskListUpdateTimeLeft({required this.minutesLeft, required this.secondsLeft, required this.taskId});
}