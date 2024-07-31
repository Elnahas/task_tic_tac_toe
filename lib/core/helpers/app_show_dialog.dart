import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_colors.dart';
import '../widgets/app_elevated_button.dart';

bool isDialogOpen = false;

Future<void> appShowDialog(BuildContext context, String error,
    {Function()? onPressed}) async {
  if (isDialogOpen) {
    return;
  }

  isDialogOpen = true;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
              onPressed: onPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
              width: 70.w,
            ),
          ),
        ],
      );
    },
  ).then((_) {
    isDialogOpen = false;
  });
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    },
  );
}
