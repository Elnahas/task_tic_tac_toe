import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
    final String buttonText;
  final void Function()? onPressed;
  final double? width;
  const AppElevatedButton({super.key, required this.buttonText, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            minimumSize: Size(width ?? double.infinity, 50.h)),
        onPressed: onPressed,
        child:  Text(
          buttonText,
          style:const  TextStyle(color: AppColors.white),
        ));
  }
}
