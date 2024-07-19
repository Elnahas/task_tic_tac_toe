import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tic_tac_toe/features/splash/data/repo/splash_repository.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _repository;
  SplashCubit(this._repository) : super(SplashInitial());

  Future<void> signInAnonymously() async {
    try {
      await _repository.signInAnonymously();
    } catch (e) {
      emit(SplashFailure(e.toString()));
    }
  }

  Future<void> checkUser() async {
    emit(SplashLoading());
    try {
      final isLogin = await _repository.checkUser();
      if (!isLogin) {
        await signInAnonymously();
      }

      emit(SplashSuccess());
    } catch (e) {
      emit(SplashFailure(e.toString()));
    }
  }
}
