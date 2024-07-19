import 'package:flutter/material.dart';

import '../widget/splash_bloc_consumer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBlocConsumer()
    );
  }
}
