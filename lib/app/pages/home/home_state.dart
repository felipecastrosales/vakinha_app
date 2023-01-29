import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/models/product_model.dart';

part 'home_state.g.dart';

@match
enum HomePageStatus {
  initial,
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  const HomeState({
    required this.status,
    required this.products,
    this.errorMessage,
    required this.shoppingBag,
  });

  const HomeState.initial()
      : status = HomePageStatus.initial,
        products = const [],
        errorMessage = null,
        shoppingBag = const [];

  final HomePageStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final List<OrderProductDto> shoppingBag;

  @override
  List<Object?> get props => [
        status,
        products,
        errorMessage,
        shoppingBag,
      ];

  HomeState copyWith({
    HomePageStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<OrderProductDto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }
}
