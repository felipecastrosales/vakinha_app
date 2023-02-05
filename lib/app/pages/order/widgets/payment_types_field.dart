import 'package:flutter/material.dart';

import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:vakinha_app/app/core/ui/helpers/sizes_extensions.dart';
import 'package:vakinha_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_app/app/models/payment_type_model.dart';

class PaymentTypesField extends StatelessWidget {
  const PaymentTypesField({
    super.key,
    required this.paymentTypes,
    required this.onChanged,
    required this.isValid,
    required this.selectedValue,
  });

  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> onChanged;
  final bool isValid;
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
            style: context.textStyles.textRegular.copyWith(fontSize: 16),
          ),
          SmartSelect<String>.single(
            title: '',
            placeholder: '',
            modalFilter: false,
            groupCounter: false,
            choiceGrouped: true,
            selectedValue: selectedValue,
            choiceType: S2ChoiceType.radios,
            modalType: S2ModalType.bottomSheet,
            onChange: (selected) => onChanged(
              int.parse(selected.value),
            ),
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
                  if (isValid) const SizedBox.shrink() else const Divider(),
                  if (isValid)
                    const SizedBox.shrink()
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Selecione uma forma de pagamento',
                        style: context.textStyles.textRegular.copyWith(
                          color: Colors.red,
                          fontSize: 13,
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
              source: paymentTypes
                  .map(
                    (payment) => {
                      'value': payment.id.toString(),
                      'title': payment.name,
                    },
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
