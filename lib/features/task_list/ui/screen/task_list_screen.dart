import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/core/helpers/spacing.dart';
import 'package:task_tic_tac_toe/core/widgets/custom_app_bar.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_status_list_view.dart';

import '../widgets/task_list_bloc_builder.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "tic tac toe"),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child:  Column(
            children: [
              const TaskStatusListView(),
              verticalSpace(10),
              const TaskListBlocBuilder(),
            ],
          ),
        ));
  }
}
