import 'package:flutter/material.dart';

import 'core/ui/theme/theme_config.dart';
import 'pages/home/home_router.dart';
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
        },
      ),
    );
  }
}
