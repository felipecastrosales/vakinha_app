import 'package:flutter/material.dart';
import 'package:vakinha_app/app/core/ui/styles/app_colors.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int amount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onDecrement,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textRegular.copyWith(
              fontSize: 17,
              color: context.appColors.secondary,
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '+',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: 22,
                  color: context.appColors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
