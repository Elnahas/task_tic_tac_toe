import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repositories/task_repository.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepository taskRepository;

  AddTaskCubit(this.taskRepository) : super(AddTaskInitial());

    void createTasks({
    required int numberOfTasks,
    required int sequenceOfTasks,
  }) async {
    emit(AddTaskLoading());
    try {
      await taskRepository.createTasks(
        numberOfTasks: numberOfTasks,
        sequenceOfTasks: sequenceOfTasks,
      );
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailure(e.toString()));
    }
  }
}
