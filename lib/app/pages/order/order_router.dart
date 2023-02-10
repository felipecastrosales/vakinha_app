import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_app/app/repositories/order/order_repository.dart';
import 'package:vakinha_app/app/repositories/order/order_repository_impl.dart';

import 'controller/order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => RepositoryProvider<OrderRepository>(
        create: (context) => OrderRepositoryImpl(
          dio: context.read<CustomDio>(),
        ),
        child: BlocProvider(
          create: (context) => OrderController(
            orderRepository: context.read<OrderRepository>(),
          ),
          child: const OrderPage(),
        ),
      );
}
