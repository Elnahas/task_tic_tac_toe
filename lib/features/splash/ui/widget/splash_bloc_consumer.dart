import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../logic/splash_cubit.dart';

class SplashBlocConsumer extends StatelessWidget {
  const SplashBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SplashCubit, SplashState>(
        listenWhen: (previous, current) => current is SplashSuccess,
        listener: (context, state) {
          if (state is SplashSuccess) {
            context.pushReplacementNamed(Routes.addTask);
          }
        },
        buildWhen: (previous, current) => current is SplashLoading,
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
  }
}