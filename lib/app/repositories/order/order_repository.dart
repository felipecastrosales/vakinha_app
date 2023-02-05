import 'package:vakinha_app/app/dto/order_dto.dart';
import 'package:vakinha_app/app/models/payment_type_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentsTypes();
  Future<void> saveOrder(OrderDto order);
}
