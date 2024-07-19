import 'package:flutter/material.dart';

import '../../../../core/data/model/task_model.dart';
import '../../../../core/helpers/date_helper.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItem({
    super.key, required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        
        title: Text(taskModel.title),
        trailing:  Text(DateHelper.formatTimestampToMinutesAndSeconds(taskModel.dueTime.toDate())),
      ),
    );
  }
}
