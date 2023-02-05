import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';

class PaymentTypesField extends StatelessWidget {
  const PaymentTypesField({
    super.key,
    required this.onChanged,
    required this.valid,
    required this.selectedValue,
  });

  final ValueChanged<int> onChanged;
  final bool valid;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Forma de pagamento',
            style: context.textStyles.textRegular.copyWith(
              fontSize: 16,
            ),
          ),
          SmartSelect.single(
            title: '',
            placeholder: '',
            modalFilter: false,
            groupCounter: false,
            choiceGrouped: true,
            selectedValue: selectedValue,
            choiceType: S2ChoiceType.radios,
            modalType: S2ModalType.bottomSheet,
            onChange: (value) => onChanged(int.parse(value.value)),
            tileBuilder: (context, state) => InkWell(
              onTap: state.showModal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: context.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selected.title ?? '',
                          style: context.textStyles.textRegular,
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                  if (valid) const SizedBox.shrink() else const Divider(),
                  if (valid)
                    const SizedBox.shrink()
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Selecione uma forma de pagamento',
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            choiceItems: S2Choice.listFrom(
              title: (_, item) => item['title'] ?? '',
              value: (_, item) => item['value'] ?? '',
              group: (_, item) => 'Selecione uma forma de pagamento',
              source: [
                {'title': 'Cartão de crédito', 'value': '1'},
                {'title': 'Cartão de débito', 'value': '2'},
                {'title': 'Boleto', 'value': '3'},
              ],
            ),
          ),
        ],
      ),
    );
  }
}
