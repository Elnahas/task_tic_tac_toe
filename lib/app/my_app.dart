import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tic_tac_toe/core/routing/routes.dart';
import 'package:task_tic_tac_toe/core/theming/app_colors.dart';
import '../core/routing/app_router.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Tic Tac Toe Tasks',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            scaffoldBackgroundColor: AppColors.white,
            useMaterial3: true,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: Routes.taskList,
        );
      },
    );
  }
}
