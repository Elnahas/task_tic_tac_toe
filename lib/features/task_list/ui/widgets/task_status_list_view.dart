import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_status_item.dart';

class TaskStatusListView extends StatefulWidget {
  const TaskStatusListView({super.key});

  @override
  State<TaskStatusListView> createState() => _TaskStatusListViewState();
}

class _TaskStatusListViewState extends State<TaskStatusListView> {
  int selectedStateJobIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 55.h,
        width: double.infinity,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  selectedStateJobIndex = index;
                  setState(() {});
                },
                child: TaskStatusItem(
                    selectedStateJobIndex: selectedStateJobIndex, index: index),
              ),
            );
          },
          itemCount: TaskStatus.values.length,
        ));
  }
}
