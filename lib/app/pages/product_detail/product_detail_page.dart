import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_app/app/core/extensions/formatter_extension.dart';

import 'package:vakinha_app/app/core/ui/base_state/base_state.dart';
import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vakinha_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:vakinha_app/app/models/product_model.dart';
import 'package:vakinha_app/app/pages/product_detail/product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.percentHeight(.4),
            width: context.screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: context.textStyles.textExtraBold.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 68,
                width: context.percentWidth(.5),
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, state) {
                    return DeliveryIncrementDecrementButton(
                      amount: state,
                      onIncrement: () {
                        controller.increment();
                      },
                      onDecrement: () {
                        controller.decrement();
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 68,
                width: context.percentWidth(.5),
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adicionar',
                            style: context.textStyles.textExtraBold.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              (widget.product.price * state).currencyPTBR,
                              maxLines: 1,
                              minFontSize: 5,
                              maxFontSize: 13,
                              textAlign: TextAlign.center,
                              style: context.textStyles.textExtraBold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
