import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/core/helpers/spacing.dart';
import 'package:task_tic_tac_toe/core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';

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
            children: [
              verticalSpace(20),
              const AppTextFormField(labelText: "Number of task"),
              verticalSpace(20),
              const AppTextFormField(labelText: "Sequence of task"),
              verticalSpace(20),
              const AppElevatedButton(
                buttonText: "Go",
              )
            ],
          ),
        ),
      ),
    );
  }
}
