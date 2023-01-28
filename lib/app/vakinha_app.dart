import 'package:flutter/material.dart';
import 'package:vakinha_app/app/pages/auth/register/register_page.dart';

import 'core/ui/theme/theme_config.dart';
import 'pages/auth/login/login_page.dart';
import 'pages/home/home_router.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_page.dart';
import 'provider/application_binding.dart';

class VakinhaApp extends StatelessWidget {
  const VakinhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Vakinha',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/product-detail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => const LoginPage(),
          '/auth/register': (context) => const RegisterPage(),
        },
      ),
    );
  }
}
