import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
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
  String currentPlayer = 'X';
  bool gameFinished = false;

  // Timer
  Timer? _timer;

  Future<void> getTasks(String status) async {
    emit(TaskListLoading());
    try {
      var tasks = await _repository.getTasks(status);
      selectedStatus = status;
      if (tasks.isEmpty) {
        emit(TaskListNoResultsFound(status));
      } else {
        emit(TaskListSuccess(tasks));
      }
    } catch (e) {
      emit(TaskListFailure(e.toString()));
    }
  }

  Future<void> updateTask(String taskId, String status) async {
    emit(TaskListUpdateLoading());

    try {
      if (await _canUpdateTask()) {
        await _repository.updateTask(taskId, status);
        emit(TaskListUpdated());
        getTasks(selectedStatus);
      } else {
        emit(TaskListFailure("You have an assigned task"));
      }
    } catch (e) {
      emit(TaskListFailure(e.toString()));
    }
  }

  Future<bool> _canUpdateTask() async {
    if (selectedStatus == TaskStatus.unassigned.name) {
      return !(await _repository.hasAssigned());
    }
    return true;
  }

  void initializeGame() {
    board = List.generate(boardSize, (_) => List.filled(boardSize, ''));
    currentPlayer = 'X';
    gameFinished = false;
    stopTimerForTask(selectedTaskAssignedId);
  }

  void makeMove(TaskModel taskModel, int row, int col) {
    if (board[row][col].isEmpty && !gameFinished) {
      board[row][col] = currentPlayer;
      if (checkWinner(row, col)) {
        gameFinished = true;
        stopTimerForTask(taskModel.id);
        emit(TaskListGameFinished(taskModel.id, winner: currentPlayer));
      } else if (board.expand((e) => e).every((cell) => cell.isNotEmpty)) {
        gameFinished = true;
        stopTimerForTask(taskModel.id);
        emit(TaskListGameFinished(taskModel.id, winner: 'Draw'));
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        emit(
            TaskListGameInProgress(board: board, currentPlayer: currentPlayer));
        if (currentPlayer == 'O' && !gameFinished) {
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

  void startTaskTimer(TaskModel task, ValueNotifier<int> taskTimerNotifier,
      ValueNotifier<TaskStatus> taskStatusNotifier) {
    DateTime dueDateTime = task.dueTime.toDate();
    int totalSeconds = dueDateTime.minute * 60 + dueDateTime.second;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        taskTimerNotifier.value = totalSeconds;

        if (taskStatusNotifier.value != TaskStatus.assigned) {
          timer.cancel();
        }
      } else {
        timer.cancel();
        taskStatusNotifier.value = TaskStatus.completed;
        emit(TaskListGameFinished(winner: 'TimeOut', task.id));
      }
    });
  }

  void stopTimerForTask(String taskId) {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
