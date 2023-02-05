import 'order_product_dto.dart';

class OrderDto {
  const OrderDto({
    required this.products,
    required this.address,
    required this.document,
    required this.paymentMethodId,
  });

  final List<OrderProductDto> products;
  final String address;
  final String document;
  final int paymentMethodId;
}
