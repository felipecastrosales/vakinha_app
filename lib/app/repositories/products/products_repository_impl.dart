import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import 'package:vakinha_app/app/core/exceptions/repository_exception.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_app/app/models/product_model.dart';

import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({
    required CustomDio dio,
  }) : _dio = dio;

  final CustomDio _dio;

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await _dio.unAuth().get('/products');
      final data = result.data
          .map<ProductModel>((product) => ProductModel.fromMap(product))
          .toList();
      return data;
    } on DioError catch (e, s) {
      developer.log(
        'Error to find all products',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
