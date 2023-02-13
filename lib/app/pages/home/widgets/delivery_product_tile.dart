import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vakinha_app/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_app/app/core/ui/styles/app_colors.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/models/product_model.dart';
import 'package:vakinha_app/app/pages/home/home_controller.dart';

class DeliveryProductTile extends StatelessWidget {
  const DeliveryProductTile({
    super.key,
    required this.product,
    required this.orderProduct,
  });

  final ProductModel product;
  final OrderProductDto? orderProduct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final homeController = context.read<HomeController>();

        final orderProdutResult = await Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: {
            'product': product,
            'order': orderProduct,
          },
        );

        if (orderProdutResult != null) {
          homeController.addOrUpdateBag(orderProdutResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.name,
                      style: context.textStyles.textExtraBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.description,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      product.price.currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: context.appColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
