import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_app/app/core/exceptions/expire_token_exception.dart';
import 'package:vakinha_app/app/core/global/global_context.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required CustomDio dio,
  }) : _dio = dio;

  final CustomDio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('accessToken');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken();
          await _retryRequest(err, handler);
        } else {
          await GlobalContext.instance.loginExpire();
        }
      } catch (_) {
        await GlobalContext.instance.loginExpire();
      }
    } else {
      return handler.next(err);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final refreshToken = sharedPreferences.getString('refreshToken');

      if (refreshToken == null) {
        return;
      }

      final resultRefresh = await _dio.auth().put<Map<String, dynamic>>(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      await sharedPreferences.setString(
        'accessToken',
        resultRefresh.data!['access_token'],
      );

      await sharedPreferences.setString(
        'refreshToken',
        resultRefresh.data!['refresh_token'],
      );
    } on DioError catch (e, s) {
      log('Erro ao realizar refresh token', error: e, stackTrace: s);
      throw ExpireTokenException();
    }
  }

  Future<void> _retryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    final result = await _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
    );

    return handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
