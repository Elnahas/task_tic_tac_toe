import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_status_item.dart';

class TaskStatusListView extends StatefulWidget {
  const TaskStatusListView({super.key});

  @override
  State<TaskStatusListView> createState() => _TaskStatusListViewState();
}

class _TaskStatusListViewState extends State<TaskStatusListView> {
  int selectedStateTaskIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60.h,
        width: double.infinity,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  if(selectedStateTaskIndex != index){
                  var status = TaskStatus.values[index].name;
                  context.read<TaskListCubit>().getTasks(status: status);
                  selectedStateTaskIndex = index;
                  setState(() {});
                  }
                },
                child: TaskStatusItem(
                    selectedStateTaskIndex: selectedStateTaskIndex, index: index),
              ),
            );
          },
          itemCount: TaskStatus.values.length,
        ));
  }
}
