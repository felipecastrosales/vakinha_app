import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  const DeliveryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 50,
    this.width,
  });

  final String label;
  final VoidCallback onPressed;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(label),
      ),
    );
  }
}
