import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';

class OrderField extends StatelessWidget {
  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.inputFormatters,
  });

  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final defaultBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: context.textStyles.textRegular.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: defaultBorder,
            ),
          ),
        ],
      ),
    );
  }
}
