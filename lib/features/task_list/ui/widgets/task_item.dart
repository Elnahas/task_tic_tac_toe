import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/enum/task_status.dart';
import '../../../../core/data/model/task_model.dart';
import '../../../../core/helpers/date_helper.dart';
import '../../logic/task_list_cubit.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;

  const TaskItem({super.key, required this.taskModel});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late ValueNotifier<TaskStatus> taskStatusNotifier;
  late ValueNotifier<int> taskTimerNotifier;

  @override
  void initState() {
    super.initState();
    taskStatusNotifier = ValueNotifier<TaskStatus>(widget.taskModel.status);
    taskTimerNotifier = ValueNotifier<int>(
        widget.taskModel.dueTime.toDate().minute * 60 +
            widget.taskModel.dueTime.toDate().second);

    final taskListCubit = context.read<TaskListCubit>();
    if (widget.taskModel.status == TaskStatus.assigned) {
      taskListCubit.startTaskTimer(
          widget.taskModel, taskTimerNotifier, taskStatusNotifier);
    }
  }

  @override
  void dispose() {
    taskStatusNotifier.dispose();
    taskTimerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskListCubit = context.read<TaskListCubit>();

    return GestureDetector(
      onTap: () {
        if (taskStatusNotifier.value == TaskStatus.unassigned) {
          taskListCubit.updateTask(
              widget.taskModel.id, TaskStatus.assigned.name);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(widget.taskModel.title),
          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    return ValueListenableBuilder<TaskStatus>(
      valueListenable: taskStatusNotifier,
      builder: (context, status, _) {
        if (status == TaskStatus.completed) {
          return const SizedBox.shrink();
        } else if (status == TaskStatus.unassigned) {
          return Text(
            DateHelper.formatTimestampToMinutesAndSeconds(
                widget.taskModel.dueTime.toDate()),
          );
        } else if (status == TaskStatus.assigned) {
          return ValueListenableBuilder<int>(
            valueListenable: taskTimerNotifier,
            builder: (context, remainingSeconds, _) {
              int minutesLeft = remainingSeconds ~/ 60;
              int secondsLeft = remainingSeconds % 60;
              return Text(
                "$minutesLeft:$secondsLeft",
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
