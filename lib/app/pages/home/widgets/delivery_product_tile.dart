import 'package:flutter/material.dart';
import 'package:vakinha_app/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_app/app/core/ui/styles/app_colors.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';

import 'package:vakinha_app/app/models/product_model.dart';

class DeliveryProductTile extends StatelessWidget {
  const DeliveryProductTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: product.image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
