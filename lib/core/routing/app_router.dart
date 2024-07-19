import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/di/service_locator.dart';
import 'package:task_tic_tac_toe/core/routing/routes.dart';
import 'package:task_tic_tac_toe/features/add_task/ui/screen/add_task_screen.dart';
import 'package:task_tic_tac_toe/features/splash/logic/splash_cubit.dart';

import '../../features/splash/ui/screen/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SplashCubit(getIt())..checkUser(),
                  child: const SplashScreen(),
                ));
      case Routes.addTask:
        return MaterialPageRoute(builder: (context) => const AddTaskScreen());
      default:
        return null;
    }
  }
}
