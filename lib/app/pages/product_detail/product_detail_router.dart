import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRouter {
  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductDetailController(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;
          final product = args['product'];
          final order = args['order'];

          return ProductDetailPage(
            product: product,
            order: order,
          );
        },
      );
}
