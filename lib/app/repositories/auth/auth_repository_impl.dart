import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:vakinha_app/app/core/exceptions/repository_exception.dart';
import 'package:vakinha_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_app/app/models/auth_model.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required CustomDio dio,
  }) : _dio = dio;

  final CustomDio _dio;

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await _dio.unAuth().post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );
      return AuthModel.fromMap(response.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        developer.log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      developer.log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Erro ao realizar login',
      );
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.unAuth().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e, s) {
      developer.log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Erro ao registrar usuário',
      );
    }
  }
}
