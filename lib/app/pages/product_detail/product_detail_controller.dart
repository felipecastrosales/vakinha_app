import 'package:bloc/bloc.dart';

class ProductDetailController extends Cubit<int> {
  ProductDetailController() : super(1);

  final amount = 1;

  void increment() => emit(state + 1);
  void decrement() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
