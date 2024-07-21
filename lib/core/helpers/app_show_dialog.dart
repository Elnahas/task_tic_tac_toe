import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/helpers/extensions.dart';

import '../theming/app_colors.dart';
import '../widgets/app_elevated_button.dart';

Future<void> appShowDialog(BuildContext context, String error , {Function()? onPressed}) {
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          actions: [
            Center(
              child: AppElevatedButton(
                buttonText: "Ok",
                onPressed: onPressed ?? () {
                  context.pop();
                },
                width: 70.w,
              ),
            )
          ],
        );
      });
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    },
  );
}
