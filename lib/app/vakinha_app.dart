import 'package:flutter/material.dart';
import 'package:vakinha_app/app/core/ui/theme/theme_config.dart';

import 'pages/splash/splash_page.dart';

class VakinhaApp extends StatelessWidget {
  const VakinhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vakinha',
      theme: ThemeConfig.theme,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => Container(),
        '/signup': (context) => Container(),
        '/home': (context) => Container(),
      },
    );
  }
}
