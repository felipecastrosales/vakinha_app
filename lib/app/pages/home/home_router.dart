import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_app/app/core/rest_client/custom_dio.dart';
import 'package:vakinha_app/app/repositories/products/products_repository.dart';
import 'package:vakinha_app/app/repositories/products/products_repository_impl.dart';

import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(
              dio: context.read()<CustomDio>(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
