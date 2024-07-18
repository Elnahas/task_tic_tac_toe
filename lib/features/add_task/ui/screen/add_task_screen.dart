import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/add_task_form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "tic tac toe",
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [verticalSpace(20), const AddTaskForm()],
          ),
        ),
      ),
    );
  }
}
