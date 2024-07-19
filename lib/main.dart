import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/app/my_app.dart';
import 'package:task_tic_tac_toe/core/helpers/app_bloc_observer.dart';
import 'package:task_tic_tac_toe/firebase_options.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupGetIt();

  runApp(MyApp(appRouter: AppRouter()));
}
