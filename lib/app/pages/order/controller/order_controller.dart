import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vakinha_app/app/dto/order_dto.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/repositories/order/order_repository.dart';

import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  OrderController({
    required OrderRepository orderRepository,
  })  : _repository = orderRepository,
        super(const OrderState.initial());

  final OrderRepository _repository;

  Future<void> load(List<OrderProductDto> products) async {
    emit(
      state.copyWith(status: OrderStatus.loading),
    );
    try {
      final paymentTypes = await _repository.getAllPaymentsTypes();
      emit(
        state.copyWith(
          orderProducts: products,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e, s) {
      log('Erro ao buscar tipos de pagamento', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OrderStatus.error,
          errorMessage: 'Erro ao buscar tipos de pagamento',
        ),
      );
    }
  }

  void incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(
      state.copyWith(orderProducts: orders, status: OrderStatus.updatedOrder),
    );
  }

  void decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    final amount = order.amount;

    if (amount == 1) {
      if (state.status != OrderStatus.confirmDeleteProduct) {
        emit(
          OrderConfirmDeleteProductState(
            orderProduct: order,
            index: index,
            status: OrderStatus.confirmDeleteProduct,
            orderProducts: state.orderProducts,
            paymentTypes: state.paymentTypes,
            errorMessage: state.errorMessage,
          ),
        );
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: amount - 1);
    }

    if (orders.isEmpty) {
      emit(
        state.copyWith(status: OrderStatus.emptyBag),
      );
      return;
    }

    emit(
      state.copyWith(
        orderProducts: orders,
        status: OrderStatus.updatedOrder,
      ),
    );
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  Future<void> saveOrder({
    required String address,
    required String document,
    required int paymentMethodId,
  }) async {
    emit(
      state.copyWith(status: OrderStatus.loading),
    );
    try {
      await _repository.saveOrder(
        OrderDto(
          products: state.orderProducts,
          address: address,
          document: document,
          paymentMethodId: paymentMethodId,
        ),
      );
      emit(
        state.copyWith(status: OrderStatus.success),
      );
    } catch (e, s) {
      log('Erro ao salvar pedido', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OrderStatus.error,
          errorMessage: 'Erro ao salvar pedido',
        ),
      );
    }
  }
}
