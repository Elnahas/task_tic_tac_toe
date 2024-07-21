import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/core/helpers/extensions.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_list_view.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/tic_tac_toe_board.dart';

import '../../../../core/data/enum/task_status.dart';
import '../../../../core/helpers/app_show_dialog.dart';
import '../../../../core/theming/app_colors.dart';

class TaskListBlocConsumer extends StatelessWidget {
  const TaskListBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskListCubit, TaskListState>(
      listenWhen: (previous, current) =>
          current is TaskListUpdated ||
          current is TaskListUpdateLoading ||
          current is TaskListFailure ||
          current is TaskListGameFinished,
      listener: (context, state) {
        if (state is TaskListUpdateLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                );
              });
        } else if (state is TaskListFailure) {
          context.pop();
          appShowDialog(context, state.error);
        } else if (state is TaskListGameFinished) {
          appShowDialog(
            context,
            state.winner == 'TimeOut'
                ? 'Time is ended try with another one!'
                : (state.winner == "Draw"
                    ? 'It\'s a Draw!'
                    : "Winner is Player ${state.winner}"),
            onPressed: () {
              context.pop();
              context.read<TaskListCubit>().initializeGame();
              if (state.winner == "X") {
                context
                    .read<TaskListCubit>()
                    .updateTask(state.taskId, TaskStatus.completed.name);
              } else if (state.winner == "TimeOut") {
                context
                    .read<TaskListCubit>()
                    .updateTaskArchive(state.taskId, true);
              } else if (state.winner == "O" || state.winner == "Draw") {
                context
                    .read<TaskListCubit>()
                    .getTasks(context.read<TaskListCubit>().selectedStatus);
              }

              //context.read<TaskListCubit>().getTasks(context.read<TaskListCubit>().selectedStatus);
            },
          );
        } else if (state is TaskListUpdated) {
          context.pop();
        }
      },
      builder: (context, state) {
        return BlocBuilder<TaskListCubit, TaskListState>(
          buildWhen: (previous, current) =>
              current is TaskListSuccess ||
              current is TaskListLoading ||
              current is TaskListNoResultsFound,
          builder: (context, state) {
            if (state is TaskListLoading) {
              return setupLoading();
            } else if (state is TaskListSuccess) {
              return setupSuccess(context, state.listTask);
            } else if (state is TaskListNoResultsFound) {
              return setupEmpty(context, state.status);
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget setupLoading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget setupSuccess(BuildContext context, List<TaskModel> tasks) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TaskListView(tasks: tasks),
          if (tasks.isNotEmpty) ...[
            TicTacToeBoard(taskModel: tasks[0]),
          ],
        ],
      ),
    );
  }

  Widget setupEmpty(BuildContext context, String status) {
    return Expanded(
      child: Center(child: placeholderTaskStatus(context, status)),
    );
  }
}

Widget placeholderTaskStatus(BuildContext context, String status) {
  if (status == TaskStatus.assigned.name) {
    return const Text("Assign tasks to play Tic Tac Toe");
  } else if (status == TaskStatus.unassigned.name) {
    return ElevatedButton(
        onPressed: () async {
          context.read<TaskListCubit>().reloadTasks();
        },
        child: const Text("Reload Tasks"));
  } else if (status == TaskStatus.completed.name) {
    return const Text("There is no completed tasks");
  }
  return const SizedBox.shrink();
}
