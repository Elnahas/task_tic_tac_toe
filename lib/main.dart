import 'package:flutter/material.dart';
import 'package:task_tic_tac_toe/app/my_app.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';

void main() {
  setupGetIt();
  runApp( MyApp(appRouter: AppRouter()));
}