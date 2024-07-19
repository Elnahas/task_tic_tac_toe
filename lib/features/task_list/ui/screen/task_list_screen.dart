import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/core/widgets/custom_app_bar.dart';
import 'package:task_tic_tac_toe/features/task_list/ui/widgets/task_status_list_view.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "tic tac toe"),
      body: Column(
        children: [
          TaskStatusListView() ,
          
        ],
      )
    );
  }
}