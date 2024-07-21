import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_strings.dart';

class PlayerTurnWidget extends StatelessWidget {
  final String currentPlayer;

  const PlayerTurnWidget({super.key, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.playerTurn,
            style: TextStyle(color: Colors.black, fontSize: 18.sp),
          ),
          TextSpan(
            text: "'$currentPlayer'",
            style: TextStyle(color: Colors.red, fontSize: 20.sp),
          ),
          TextSpan(
            text: AppStrings.turn,
            style: TextStyle(color: Colors.black, fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
