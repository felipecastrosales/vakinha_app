import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';

import 'package:vakinha_app/app/pages/home/home_state.dart';
import 'package:vakinha_app/app/repositories/products/products_repository.dart';

class HomeController extends Cubit<HomeState> {
  HomeController({
    required ProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(
          const HomeState.initial(),
        );

  final ProductsRepository _productsRepository;

  Future<void> loadProducts() async {
    emit(
      state.copyWith(status: HomePageStatus.loading),
    );
    try {
      final products = await _productsRepository.findAllProducts();
      emit(
        state.copyWith(
          status: HomePageStatus.success,
          products: products,
        ),
      );
    } catch (e, s) {
      developer.log(
        'Error to load products',
        error: e,
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: HomePageStatus.error,
          errorMessage: 'Erro ao buscar produtos',
        ),
      );
    }
  }
}
