import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import '../../../../core/data/model/task_model.dart';
import '../../../../core/helpers/date_helper.dart';
import '../../logic/task_list_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItem({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (taskModel.status == TaskStatus.unassigned) {
          context
              .read<TaskListCubit>()
              .assignTask(taskModel.id, TaskStatus.assigned.name);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(taskModel.title),
          trailing: taskModel.status != TaskStatus.completed
              ? ValueListenableBuilder<int>(
                  valueListenable:
                      context.read<TaskListCubit>().taskTimers[taskModel.id] ??
                          ValueNotifier(0),
                  builder: (context, value, child) {
                    return Text(
                      DateHelper.formatTimestampToMinutesAndSeconds(
                          Timestamp.fromMillisecondsSinceEpoch(value * 1000)
                              .toDate()),
                    );
                  },
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildTimerText(int remainingSeconds) {
    int minutesLeft = remainingSeconds ~/ 60;
    int secondsLeft = remainingSeconds % 60;
    return Text(
      "${minutesLeft.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}",
    );
  }
}
