import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/helpers/constants.dart';

class TicTacToeCell extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const TicTacToeCell({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 40.sp,
              color: value == Constants.playerX ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
