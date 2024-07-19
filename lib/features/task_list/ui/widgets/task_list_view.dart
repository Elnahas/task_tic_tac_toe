import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_item.dart';

import '../../../../core/data/enum/task_status.dart';
import '../../../../core/data/model/task_model.dart';

class TaskListView extends StatelessWidget {
  
  const TaskListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => TaskItem(
        taskModel: TaskModel(
            id: "1",
            title: "task 1",
            status: TaskStatus.assigned,
            dueTime: Timestamp.now()),
      ),
      itemCount: 10,
    );
  }
}
