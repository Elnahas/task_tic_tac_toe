import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit() : super(TaskListInitial());
}
