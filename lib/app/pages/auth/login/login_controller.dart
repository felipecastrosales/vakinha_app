import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_app/app/core/exceptions/unauthorized_exception.dart';

import 'package:vakinha_app/app/repositories/auth/auth_repository.dart';

import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  LoginController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState.initial());

  final AuthRepository _authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(status: LoginStatus.login),
      );
      final authModel = await _authRepository.login(email, password);
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(
        'accessToken',
        authModel.accessToken,
      );
      await sharedPreferences.setString(
        'refreshToken',
        authModel.refreshToken,
      );
      emit(
        state.copyWith(status: LoginStatus.success),
      );
    } on UnauthorizedException catch (e, s) {
      developer.log(
        'Login ou senha inválidos | UnauthorizedException',
        error: e,
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: 'Login ou senha inválidos',
        ),
      );
    } catch (e, s) {
      developer.log('Erro ao realizar login', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Erro ao realizar login',
        ),
      );
    }
  }
}
