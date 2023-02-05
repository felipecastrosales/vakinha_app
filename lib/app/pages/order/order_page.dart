import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vakinha_app/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_app/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/models/payment_type_model.dart';
import 'package:validatorless/validatorless.dart';

import 'controller/order_controller.dart';
import 'controller/order_state.dart';
import 'widgets/order_field.dart';
import 'widgets/order_product_tile.dart';
import 'widgets/payment_types_field.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressTextEditingController = TextEditingController();
  final documentTextEditingController = TextEditingController();
  final paymentTypeValid = ValueNotifier(true);
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  int? paymentTypeId;

  @override
  void onReady() {
    super.onReady();
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    addressTextEditingController.dispose();
    documentTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (_, state) {
        debugPrint('state: $state');
        state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Erro não informado');
          },
          confirmDeleteProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmDeleteProduct(state);
            }
          },
          emptyBag: () {
            showInfo(
              'Seu carrinho está vazio! Adicione produtos para continuar.',
            );
            Navigator.pop(context, const <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed(
              '/order/completed',
              result: const <OrderProductDto>[],
            );
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppBar(),
          body: Form(
            key: formKey,
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
                          onPressed: controller.emptyBag,
                          icon: Image.asset(
                            'assets/images/trashRegular.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, state) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.length,
                      (context, index) => Column(
                        children: [
                          OrderProductTile(
                            index: index,
                            orderProduct: state[index],
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      ),
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
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (_, totalOrder) => Text(
                                totalOrder.currencyPTBR,
                                style:
                                    context.textStyles.textExtraBold.copyWith(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'Endereço de entrega',
                        hintText: 'Digite um endereço',
                        controller: addressTextEditingController,
                        validator: Validatorless.required(
                          'Endereço obrigatório',
                        ),
                      ),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'CPF',
                        hintText: 'Digite o CPF',
                        inputFormatters: [cpfMask],
                        controller: documentTextEditingController,
                        validator: Validatorless.multiple([
                          Validatorless.required('CPF obrigatório'),
                          Validatorless.cpf('CPF inválido'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (_, paymentTypes) => ValueListenableBuilder(
                          valueListenable: paymentTypeValid,
                          builder: (context, paymentTypeValidValue, _) {
                            return PaymentTypesField(
                              paymentTypes: paymentTypes,
                              isValid: paymentTypeValidValue,
                              selectedValue: paymentTypeId.toString(),
                              onChanged: (value) {
                                paymentTypeId = value;
                              },
                            );
                          },
                        ),
                      ),
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
                          onPressed: () {
                            final isFormValid =
                                formKey.currentState?.validate() ?? false;
                            final hasPaymentTypeSelected =
                                paymentTypeId != null;
                            paymentTypeValid.value = hasPaymentTypeSelected;
                            if (isFormValid && hasPaymentTypeSelected) {
                              controller.saveOrder(
                                address: addressTextEditingController.text,
                                document: documentTextEditingController.text,
                                paymentMethodId: paymentTypeId!,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmDeleteProduct(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Deseja excluir o produto ${state.orderProduct.product.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.cancelDeleteProcess();
            },
            child: Text(
              'Cancelar',
              style: context.textStyles.textBold.copyWith(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.decrementProduct(state.index);
            },
            child: Text(
              'Confirmar',
              style: context.textStyles.textBold,
            ),
          ),
        ],
      ),
    );
  }
}
