import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_app/app/core/extensions/formatter_extension.dart';
import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/dto/order_product_dto.dart';
import 'package:vakinha_app/app/pages/home/home_controller.dart';

class ShopppingBagWidget extends StatelessWidget {
  const ShopppingBagWidget({
    super.key,
    required this.bag,
  });

  final List<OrderProductDto> bag;

  Future<void> _goOrder(BuildContext context, [bool mounted = true]) async {
    final controller = context.read<HomeController>();
    final sharedPreferences = await SharedPreferences.getInstance();

    if (!mounted) return;
    final navigator = Navigator.of(context);
    if (!sharedPreferences.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');
      if (loginResult == null || loginResult == false) {
        return;
      }
    }
    final updatedBag = await navigator.pushNamed('/order', arguments: bag);
    controller.updateBag(
      (updatedBag ?? const <OrderProductDto>[]) as List<OrderProductDto>,
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalBag = bag
        .fold<double>(0.0, (total, item) => total += item.totalPrice)
        .currencyPTBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 30,
              ),
            ),
            Align(
              child: Text(
                'Ver Carrinho',
                style: context.textStyles.textBold.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textBold.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
