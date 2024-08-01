import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/core/helpers/app_strings.dart';
import 'package:task_tic_tac_toe/core/helpers/constants.dart';
import 'package:task_tic_tac_toe/core/repositories/task_repository.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final TaskRepository _repository;
  TaskListCubit(this._repository) : super(TaskListInitial());
  String selectedStatus = TaskStatus.values[0].name;
  String selectedTaskAssignedId = "";

  //Tic tac toe
  static const int boardSize = 3;
  List<List<String>> board =
      List.generate(boardSize, (_) => List.filled(boardSize, ''));
  String currentPlayer = Constants.playerX;
  bool gameFinished = false;

  Map<String, ValueNotifier<int>> taskTimers = {};

  Future<void> getTasks(String status, {bool reload = false}) async {
    emit(TaskListLoading());
    try {
      if (reload) {
        await _repository.reloadTasks();
      }
      var tasks = await _repository.getTasks(status);
      selectedStatus = status;
      if (tasks.isEmpty) {
        emit(TaskListNoResultsFound(status));
      } else {
        for (var task in tasks) {
          if (!taskTimers.containsKey(task.id) &&
              task.status != TaskStatus.completed) {
            taskTimers[task.id] = ValueNotifier<int>(task.dueTime.seconds);
            _startTimer(task);
          }
        }
        emit(TaskListSuccess(tasks));
      }
    } catch (e) {
      emit(TaskListFailure(e.toString()));
    }
  }
Future<void> updateTask(String taskId, String status) async {
  emit(TaskListUpdateLoading());

  try {
    await _updateTask(taskId, status);
  } catch (e) {
    emit(TaskListFailure(e.toString()));
  }
}

  Future<void> _updateTask(String taskId, String status) async {
  try {
    if (status == TaskStatus.assigned.name) {
      selectedTaskAssignedId = taskId;
    }
    await _repository.updateTask(taskId, status);
    emit(TaskListUpdated());
    await getTasks(selectedStatus);
  } catch (e) {
    emit(TaskListFailure(e.toString()));
  }
}

  bool _canUpdateTask() {
    if (selectedTaskAssignedId.isNotEmpty) {
      return false;
    }
    return true;
  }

  Future<void> assignTask(String taskId, String status) async {
    emit(TaskListUpdateLoading());
  try {
    if (_canUpdateTask()) {
      await _updateTask(taskId, status);
    } else {
      emit(TaskListFailure(AppStrings.anAssignedTask));
    }
  } catch (e) {
    emit(TaskListFailure(e.toString()));
  }
}

  Future<void> updateTaskArchive(String taskId, bool isArchive) async {
    emit(TaskListUpdateLoading());
    try {
      await _repository.updateTaskArchive(taskId, isArchive);
      emit(TaskListUpdated());
      if (selectedStatus != TaskStatus.completed.name) {
        getTasks(selectedStatus);
      }
    } catch (e) {
      emit(TaskListFailure(e.toString()));
    }
  }

  // Future<bool> _canUpdateTask() async {
  //   if (selectedStatus == TaskStatus.unassigned.name) {
  //     return !(await _repository.hasAssigned());
  //   }
  //   return true;
  // }

  void initializeGame() {
    board = List.generate(boardSize, (_) => List.filled(boardSize, ''));
    currentPlayer = Constants.playerX;
    gameFinished = false;
  }

void _finishGame(TaskModel taskModel, String winner) {
  gameFinished = true;
  selectedTaskAssignedId = "";
  stopTimer(taskModel.id);
  emit(TaskListGameFinished(taskModel, winner: winner));
}

void makeMove(TaskModel taskModel, int row, int col) {
  if (board[row][col].isEmpty && !gameFinished) {
    board[row][col] = currentPlayer;
    if (checkWinner(row, col)) {
      _finishGame(taskModel, currentPlayer);
    } else if (board.expand((e) => e).every((cell) => cell.isNotEmpty)) {
      _finishGame(taskModel, Constants.draw);
    } else {
      currentPlayer = currentPlayer == Constants.playerX
          ? Constants.playerO
          : Constants.playerX;
      emit(TaskListGameInProgress(board: board, currentPlayer: currentPlayer));
      if (currentPlayer == Constants.playerO && !gameFinished) {
        makeComputerMove(taskModel);
      }
    }
  }
}

  void makeComputerMove(TaskModel taskModel) {
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col].isEmpty) {
          makeMove(taskModel, row, col);
          return;
        }
      }
    }
  }

  bool checkWinner(int row, int col) {
    return (board[row].every((cell) => cell == currentPlayer) ||
        board.every((row) => row[col] == currentPlayer) ||
        List.generate(boardSize, (index) => board[index][index])
            .every((cell) => cell == currentPlayer) ||
        List.generate(boardSize, (index) => board[index][boardSize - index - 1])
            .every((cell) => cell == currentPlayer));
  }

  void _startTimer(TaskModel taskModel) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (taskTimers[taskModel.id]?.value == 0) {
        timer.cancel();
        emit(TaskListGameFinished(winner: Constants.timeOut, taskModel));
        stopTimer(taskModel.id);
      } else {
        taskTimers[taskModel.id]?.value -= 1;
      }
    });
  }

  void stopTimer(String taskId) {
    taskTimers.remove(taskId);
  }

  void timeOutReturnUnassigned() {
    emit(TimeOutReturnUnassigned());
  }
}
