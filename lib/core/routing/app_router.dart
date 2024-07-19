import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/core/routing/routes.dart';

import '../../features/splash/ui/screen/splash_screen.dart';
class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      default:
        return null;
    }
  }
}
