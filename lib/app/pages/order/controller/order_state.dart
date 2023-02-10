import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
  updatedOrder,
  confirmDeleteProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  const OrderState.initial()
      : this._(
          status: OrderStatus.initial,
          orderProducts: const [],
          paymentTypes: const [],
          errorMessage: null,
        );

  const OrderState._({
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
    this.errorMessage,
  });

  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;

  double get totalOrder => orderProducts.fold(
        0,
        (previousValue, element) => previousValue + element.totalPrice,
      );

  @override
  List<Object?> get props =>
      [status, orderProducts, paymentTypes, errorMessage];

  OrderState copyWith({
    required OrderStatus status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) =>
      OrderState._(
        status: status,
        orderProducts: orderProducts ?? this.orderProducts,
        paymentTypes: paymentTypes ?? this.paymentTypes,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class OrderConfirmDeleteProductState extends OrderState {
  const OrderConfirmDeleteProductState({
    required this.orderProduct,
    required this.index,
    required super.status,
    required super.orderProducts,
    required super.paymentTypes,
    super.errorMessage,
  }) : super._();

  final OrderProductDto orderProduct;
  final int index;
}
