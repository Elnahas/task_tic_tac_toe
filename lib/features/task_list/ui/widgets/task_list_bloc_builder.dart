import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_list_view.dart';

import '../../../../core/data/enum/task_status.dart';

class TaskListBlocBuilder extends StatelessWidget {
  const TaskListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      buildWhen: (previous, current) =>
          current is TaskListSuccess ||
          current is TaskListLoading ||
          current is TaskListFailure ||
          current is TaskListNoResultsFound,
      builder: (context, state) {
        if (state is TaskListLoading) {
          return setupLoading();
        } else if (state is TaskListSuccess) {
          return setupSuccess(state.listTask);
        } else if (state is TaskListFailure) {
          return setupFailure(state.error);
        } else if (state is TaskListNoResultsFound) {
          return setupEmpty(state.status);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget setupLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget setupSuccess(List<TaskModel> tasks) {
    return TaskListView(tasks: tasks);
  }

  Widget setupFailure(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget setupEmpty(String status) {
    return Center(child: placeholderTaskStatus(status));
  }
}

Widget placeholderTaskStatus(String status) {
  if (status == TaskStatus.assigned.name) {
    return const Text("Assign tasks to play Tic Tac Toe");
  } else if (status == TaskStatus.unassigned.name) {
    return ElevatedButton(onPressed: () {}, child: const Text("Reload Tasks"));
    
  } else if (status == TaskStatus.completed.name) {
    return const Text("There is no completed tasks");
  }
  return const SizedBox.shrink();
}
