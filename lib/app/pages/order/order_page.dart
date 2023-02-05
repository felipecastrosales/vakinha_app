import 'package:flutter/material.dart';

import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/models/product_model.dart';

import 'package:validatorless/validatorless.dart';
import 'widgets/order_field.dart';
import 'widgets/order_product_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressTextEditingController = TextEditingController();
  final _documentTextEditingController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _addressTextEditingController.dispose();
    _documentTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      'Carrinho',
                      style: context.textStyles.textTitle,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/trashRegular.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) => Column(
                  children: [
                    OrderProductTile(
                      index: index,
                      orderProduct: OrderProductDto(
                        amount: 10,
                        product: ProductModel.fromMap({}),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total do pedido',
                          style: context.textStyles.textExtraBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'R\$ ${100}',
                          style: context.textStyles.textExtraBold
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  OrderField(
                    title: 'Endereço de entrega',
                    hintText: 'Digite um endereço',
                    controller: _addressTextEditingController,
                    validator: Validatorless.required(
                      'Endereço obrigatório',
                    ),
                  ),
                  const SizedBox(height: 10),
                  OrderField(
                    title: 'CPF',
                    hintText: 'Digite o CPF',
                    controller: _documentTextEditingController,
                    validator: Validatorless.multiple([
                      Validatorless.required('CPF obrigatório'),
                      Validatorless.cpf('CPF inválido'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DeliveryButton(
                      label: 'FINALIZAR',
                      width: double.infinity,
                      height: 48,
                      onPressed: () {},
                    ),
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
