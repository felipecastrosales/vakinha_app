import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:vakinha_app/app/core/exceptions/repository_exception.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_app/app/dto/order_dto.dart';
import 'package:vakinha_app/app/models/payment_type_model.dart';

import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({
    required CustomDio dio,
  }) : _dio = dio;

  final CustomDio _dio;

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await _dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((payment) => PaymentTypeModel.fromMap(payment))
          .toList();
    } on DioError catch (e, s) {
      developer.log(
        'Erro ao buscar tipos de pagamento',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Erro ao buscar tipos de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await _dio.auth().post(
        '/orders',
        data: {
          'products': order.products
              .map(
                (product) => {
                  'id': product.product.id,
                  'amount': product.amount,
                  'total_price': product.totalPrice,
                },
              )
              .toList(),
          'user_id': '#userAuthRef',
          'address': order.address,
          'CPF': order.document,
          'payment_method_id': order.paymentMethodId,
        },
      );
    } on DioError catch (e, s) {
      developer.log('Erro ao salvar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar pedido');
    }
  }
}
