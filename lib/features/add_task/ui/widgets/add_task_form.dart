import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController numberOfTaskController = TextEditingController();
  final TextEditingController sequenceOfTaskController =
      TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
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
              onPressed: isEnabled ? () {} : null,
              buttonText: "Go",
            );
          },
        ),
      ],
    );
  }
}
