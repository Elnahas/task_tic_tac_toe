import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/core/repositories/task_repository.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final TaskRepository _repository;
  TaskListCubit(this._repository) : super(TaskListInitial());

  Future<void> getTasks({String? status}) async {
    emit(TaskListLoading());
    try {
      var tasks = await _repository.getTasks(status);
      if (tasks.isEmpty) {
        emit(TaskListNoResultsFound());
      } else {
        emit(TaskListSuccess(tasks));
      }
    } catch (e) {
      emit(TaskListFailure(e.toString()));
    }
  }
}
