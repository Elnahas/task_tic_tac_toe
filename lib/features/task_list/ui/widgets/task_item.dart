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
  late TaskListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<TaskListCubit>();

    taskStatusNotifier = ValueNotifier<TaskStatus>(widget.taskModel.status);
    taskTimerNotifier = ValueNotifier<int>(
        widget.taskModel.dueTime.toDate().minute * 60 +
            widget.taskModel.dueTime.toDate().second);

    if (widget.taskModel.status == TaskStatus.assigned) {
      _cubit.startTaskTimer(
          widget.taskModel, taskTimerNotifier, taskStatusNotifier);
    }

    super.initState();
  }

  @override
  void dispose() {
    taskStatusNotifier.dispose();
    taskTimerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTaskTap,
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

  void _onTaskTap() {
    if (taskStatusNotifier.value == TaskStatus.unassigned) {
      _cubit.updateTask(widget.taskModel.id, TaskStatus.assigned.name);
    }
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
              return _buildTimerText(remainingSeconds);
            },
          );
        }
        return const SizedBox.shrink();
      },
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
