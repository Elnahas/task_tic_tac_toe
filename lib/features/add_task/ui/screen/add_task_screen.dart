import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(title: "tic tac toe",),
            Container(),
          ],
        ),
      ),
    );
  }
}