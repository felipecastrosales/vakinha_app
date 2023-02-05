import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vakinha_app/app/repositories/auth/auth_repository.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginController(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: const LoginPage(),
      );
}
