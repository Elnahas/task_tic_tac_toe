import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {

  late TaskListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<TaskListCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _cubit.selectedStatus == TaskStatus.assigned.name ?  Column(
      children: [
        Text("Player X Turn"),
        Text("Game"),
      ],
    ) : const SizedBox.shrink();
  }
}