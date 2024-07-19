import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/features/add_task/logic/add_task_cubit.dart';
import 'package:task_tic_tac_toe/features/add_task/ui/widgets/add_task_bloc_listener.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  late AddTaskCubit _cubit;
  late TextEditingController numberOfTaskController;
  late TextEditingController sequenceOfTaskController;
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    _cubit = context.read<AddTaskCubit>();
    numberOfTaskController = _cubit.numberOfTaskController;
    sequenceOfTaskController = _cubit.sequenceOfTaskController;

    numberOfTaskController.addListener(_checkIfFormIsFilled);
    sequenceOfTaskController.addListener(_checkIfFormIsFilled);
    super.initState();
  }

  void _checkIfFormIsFilled() {
    if (numberOfTaskController.text.isNotEmpty &&
        sequenceOfTaskController.text.isNotEmpty) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
  }

  @override
  void dispose() {
    numberOfTaskController.dispose();
    sequenceOfTaskController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          labelText: "Number of task",
          controller: numberOfTaskController,
          keyboardType: TextInputType.number,
        ),
        verticalSpace(20),
        AppTextFormField(
            labelText: "Sequence of task",
            controller: sequenceOfTaskController,
            keyboardType: TextInputType.number),
        verticalSpace(20),
        ValueListenableBuilder<bool>(
          valueListenable: isButtonEnabled,
          builder: (context, isEnabled, child) {
            return AppElevatedButton(
              onPressed: isEnabled
                  ? () {
                      validateToAddTasks();
                    }
                  : null,
              buttonText: "Go",
            );
          },
        ),
        const AddTaskBlocListener()
      ],
    );
  }

  void validateToAddTasks() {
    final numberOfTasks = int.tryParse(numberOfTaskController.text) ?? 0;
    final interval = int.tryParse(sequenceOfTaskController.text) ?? 0;

    if (numberOfTasks > 0 && interval > 0) {
      _cubit.createTasks(
          numberOfTasks: int.parse(numberOfTaskController.text),
          sequenceOfTasks: int.parse(sequenceOfTaskController.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields correctly')));
    }
  }
}
