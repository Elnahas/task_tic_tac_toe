import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/data/enum/task_status.dart';
import 'package:task_tic_tac_toe/core/data/model/task_model.dart';
import 'package:task_tic_tac_toe/core/helpers/spacing.dart';
import 'package:task_tic_tac_toe/features/task_list/logic/task_list_cubit.dart';

class TicTacToeBoard extends StatefulWidget {
  final TaskModel taskModel;

  const TicTacToeBoard({super.key, required this.taskModel});

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
    return _cubit.selectedStatus == TaskStatus.assigned.name
        ? Column(
            children: [
              verticalSpace(20),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Player ",
                    style: TextStyle(color: Colors.black, fontSize: 18.sp)),
                TextSpan(
                  text: "'${_cubit.currentPlayer}'",
                  style: TextStyle(color: Colors.red, fontSize: 20.sp),
                ),
                TextSpan(
                    text: " Turn",
                    style: TextStyle(color: Colors.black, fontSize: 18.sp)),
              ])),
              verticalSpace(10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<TaskListCubit>()
                          .makeMove(widget.taskModel, row, col);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(_cubit.board[row][col],
                            style: TextStyle(fontSize: 40.sp , color: _cubit.board[row][col] == "X" ? Colors.blue : Colors.red )),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
