import 'package:bloc/bloc.dart';
import 'package:vakinha_app/app/repositories/auth/auth_repository.dart';

import 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const RegisterState.initial());

  final AuthRepository _authRepository;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(status: RegisterStatus.register),
      );
      await _authRepository.register(name, email, password);
      emit(
        state.copyWith(status: RegisterStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: RegisterStatus.error),
      );
    }
  }
}
