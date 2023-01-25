import 'package:flutter/material.dart';
import 'package:vakinha_app/app/core/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Container(),
          DeliveryButton(
            width: 200,
            label: 'Entrar',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
