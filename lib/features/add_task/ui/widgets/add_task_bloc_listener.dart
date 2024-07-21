import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/helpers/extensions.dart';
import 'package:task_tic_tac_toe/features/add_task/logic/add_task_cubit.dart';
import '../../../../core/helpers/app_show_dialog.dart';
import '../../../../core/routing/routes.dart';

class AddTaskBlocListener extends StatelessWidget {
  const AddTaskBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        switch (state) {
          case AddTaskLoading():
            setupLoading(context);
            break;
          case AddTaskSuccess():
            setupSuccess(context);
            break;
          case AddTaskFailure():
            setupFailure(context, state.error);
            break;

          case AddTaskInitial():
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  setupLoading(BuildContext context) {
    showLoadingDialog(context);
  }
}

void setupSuccess(BuildContext context) {
  context.pop();
  context.pushNamed(Routes.taskList);
}

setupFailure(BuildContext context, String error) {
  context.pop();

  appShowDialog(context, error);
}
