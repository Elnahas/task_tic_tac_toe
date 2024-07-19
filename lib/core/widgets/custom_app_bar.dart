import 'package:flutter/material.dart';

import '../theming/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ),
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}