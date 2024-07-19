import 'package:get_it/get_it.dart';
import 'package:task_tic_tac_toe/core/repositories/task_repository.dart';
import 'package:task_tic_tac_toe/features/add_task/logic/add_task_cubit.dart';
import 'package:task_tic_tac_toe/features/splash/data/repo/splash_repository.dart';
import 'package:task_tic_tac_toe/features/splash/logic/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //splash
  getIt.registerSingleton<SplashRepository>(SplashRepository());
  getIt.registerLazySingleton<SplashCubit>(() => SplashCubit(getIt()));

  //Add task
  getIt.registerSingleton<TaskRepository>(TaskRepository());
  getIt.registerLazySingleton<AddTaskCubit>(() => AddTaskCubit(getIt()));
}
