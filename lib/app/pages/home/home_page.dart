import 'package:flutter/material.dart';

import 'package:vakinha_app/app/core/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/models/product_model.dart';

import 'widgets/delivery_product_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return DeliveryProductTile(
                  product: ProductModel(
                    id: '1',
                    name: 'Hamburguer',
                    description: 'Hamburguer de carne',
                    price: 10,
                    image:
                        'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
