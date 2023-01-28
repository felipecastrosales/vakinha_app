import 'package:flutter/material.dart';

import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: context.textStyles.textTitle,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: DeliveryButton(
                        width: context.screenWidth,
                        label: 'Entrar',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não possui uma conta?',
                    style: context.textStyles.textBold,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/auth/register');
                    },
                    child: Text(
                      'Cadastre-se',
                      style: context.textStyles.textBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
