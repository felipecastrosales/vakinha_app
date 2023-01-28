import 'package:flutter/material.dart';
import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/lanche.png',
                width: context.screenWidth,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentHeight(0.3),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  DeliveryButton(
                    label: 'Acessar',
                    width: context.percentWidth(0.6),
                    onPressed: () {
                      debugPrint('Acessar');
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
