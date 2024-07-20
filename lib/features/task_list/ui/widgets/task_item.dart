import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/enum/task_status.dart';
import '../../../../core/data/model/task_model.dart';
import '../../../../core/helpers/date_helper.dart';
import '../../logic/task_list_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItem({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (taskModel.status.name == TaskStatus.unassigned.name) {
          context
              .read<TaskListCubit>()
              .updateTask(taskModel.id, TaskStatus.assigned.name);
        } 
        // else if (taskModel.status.name == TaskStatus.assigned.name) {
        //   context
        //       .read<TaskListCubit>()
        //       .updateTask(taskModel.id, TaskStatus.unassigned.name);
        // }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(taskModel.title),
          trailing: taskModel.status.name == TaskStatus.completed.name
              ? null
              : Text(DateHelper.formatTimestampToMinutesAndSeconds(
                  taskModel.dueTime.toDate())),
        ),
      ),
    );
  }
}
