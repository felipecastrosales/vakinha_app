import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vakinha_app/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/pages/home/home_controller.dart';

import 'home_state.dart';
import 'widgets/delivery_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    super.onReady();
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          context.read<HomeController>().loadProducts();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro ao buscar produtos');
            },
          );
        },
        buildWhen: (previous, current) {
          return current.status.matchAny(
            any: () => false,
            loading: () => true,
            success: () => true,
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return DeliveryProductTile(
                      product: product,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
