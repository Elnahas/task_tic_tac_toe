import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';

import '../../../../core/theming/app_colors.dart';
class TaskStatusItem extends StatelessWidget {
  const TaskStatusItem({
    super.key,
    required this.selectedStateTaskIndex, required this.index,
  });

  final int selectedStateTaskIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedStateTaskIndex == index
              ? AppColors.primaryColor
              : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
            child: Text(
          TaskStatus.values[index].name,
          style:  TextStyle(color: selectedStateTaskIndex == index? Colors.white : Colors.black) ,
        )));
  }
}