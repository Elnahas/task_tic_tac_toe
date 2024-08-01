import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_item.dart';
import '../../../../core/data/model/task_model.dart';

class TaskListView extends StatelessWidget {
  final List<TaskModel> tasks;

  const TaskListView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => TaskItem(
        taskModel: tasks[index],
      ),
      itemCount: tasks.length,
    );
  }
}
