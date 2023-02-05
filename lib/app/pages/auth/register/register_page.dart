import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_app/app/core/ui/base_state/base_state.dart';
import 'package:validatorless/validatorless.dart';

import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_app/app/pages/auth/register/register_controller.dart';

import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Usuário registrado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameTextEditingController,
                    validator: Validatorless.required('Nome obrigatório'),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailTextEditingController,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordTextEditingController,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                        6,
                        'Senha deve ter no mínimo 6 caracteres',
                      ),
                    ]),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    validator: Validatorless.multiple([
                      Validatorless.required(
                          'Confirmação de senha obrigatória'),
                      Validatorless.compare(
                        _passwordTextEditingController,
                        'As senhas estão diferentes',
                      ),
                    ]),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      width: context.screenWidth,
                      label: 'Cadastrar',
                      onPressed: () {
                        final isValid =
                            _formKey.currentState?.validate() ?? false;
                        if (isValid) {
                          controller.register(
                            name: _nameTextEditingController.text,
                            email: _emailTextEditingController.text,
                            password: _passwordTextEditingController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
