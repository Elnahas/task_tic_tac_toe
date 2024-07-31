import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/core/helpers/extensions.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_list_view.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/tic_tac_toe_board.dart';
import '../../../../core/data/enum/task_status.dart';
import '../../../../core/helpers/app_show_dialog.dart';
import '../../../../core/helpers/app_strings.dart';
import '../../../../core/helpers/constants.dart';

class TaskListBlocConsumer extends StatelessWidget {
  const TaskListBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskListCubit, TaskListState>(
      listenWhen: _listenWhen,
      listener: _stateListener,
      builder: (context, state) {
        return BlocBuilder<TaskListCubit, TaskListState>(
          buildWhen: _buildWhen,
          builder: (context, state) {
            return _buildStateContent(context, state);
          },
        );
      },
    );
  }

  bool _listenWhen(TaskListState previous, TaskListState current) {
    return current is TaskListUpdated ||
        current is TaskListUpdateLoading ||
        current is TaskListFailure ||
        current is TaskListGameFinished;
  }

  void _stateListener(BuildContext context, TaskListState state) {
    if (state is TaskListUpdateLoading) {
      showLoadingDialog(context);
    } else if (state is TaskListFailure) {
      _showFailureDialog(context, state.error);
    } else if (state is TaskListGameFinished) {
      _handleGameFinished(context, state);
    } else if (state is TaskListUpdated) {
      context.pop();
    }
  }

  bool _buildWhen(TaskListState previous, TaskListState current) {
    return current is TaskListSuccess ||
        current is TaskListLoading ||
        current is TaskListNoResultsFound;
  }

  Widget _buildStateContent(BuildContext context, TaskListState state) {
    if (state is TaskListLoading) {
      return _setupLoading();
    } else if (state is TaskListSuccess) {
      return _setupSuccess(context, state.listTask);
    } else if (state is TaskListNoResultsFound) {
      return _setupEmpty(context, state.status);
    }

    return const SizedBox.shrink();
  }

  void _showFailureDialog(BuildContext context, String error) {
    context.pop();
    appShowDialog(context, error);
  }

  void _handleGameFinished(BuildContext context, TaskListGameFinished state) {
    context.read<TaskListCubit>().initializeGame();
    _handleTaskUpdateBasedOnWinner(context, state);

    String message;
    if (state.winner == Constants.timeOut) {
      message = AppStrings.timeEnded;
    } else if (state.winner == Constants.draw) {
      message = AppStrings.itsADraw;
    } else {
      message = "${AppStrings.winnerIsPlayer} ${state.winner}";
    }

    appShowDialog(
      context,
      message,
      onPressed: () {
        context.pop();
      },
    );
  }

  void _handleTaskUpdateBasedOnWinner(
      BuildContext context, TaskListGameFinished state) {
    var cubit = context.read<TaskListCubit>();
    if (state.winner == Constants.playerX) {
      cubit.updateTask(state.taskModel.id, TaskStatus.completed.name);
    } else if (state.winner == Constants.timeOut) {
      if (cubit.selectedTaskAssignedId == state.taskModel.id) {
        cubit.updateTask(state.taskModel.id, TaskStatus.unassigned.name);
        cubit.selectedTaskAssignedId = "";
      } else {
        cubit.updateTaskArchive(state.taskModel.id, true);
      }
    } else if (state.winner == Constants.playerO ||
        state.winner == Constants.draw) {
      cubit.getTasks(context.read<TaskListCubit>().selectedStatus);
    }
  }

  Widget _setupLoading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _setupSuccess(BuildContext context, List<TaskModel> tasks) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TaskListView(tasks: tasks),
          if (tasks.isNotEmpty) TicTacToeBoard(taskModel: tasks[0]),
        ],
      ),
    );
  }

  Widget _setupEmpty(BuildContext context, String status) {
    return Expanded(
      child: Center(
        child: _placeholderTaskStatus(context, status),
      ),
    );
  }

  Widget _placeholderTaskStatus(BuildContext context, String status) {
    var cubit = context.read<TaskListCubit>();
    if (status == TaskStatus.assigned.name) {
      return const Text(AppStrings.noTasksAssigned);
    } else if (status == TaskStatus.unassigned.name) {
      return ElevatedButton(
        onPressed: () async {
          cubit.getTasks(cubit.selectedStatus, reload: true);
        },
        child: const Text(AppStrings.reloadTasks),
      );
    } else if (status == TaskStatus.completed.name) {
      return const Text(AppStrings.noCompletedTasks);
    }
    return const SizedBox.shrink();
  }
}
