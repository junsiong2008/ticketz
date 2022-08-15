import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticketz/shared/constants.dart';

class RegistrationFormField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const RegistrationFormField({
    Key? key,
    required this.label,
    required this.textEditingController,
    required this.onChanged,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kFormFieldLabelTextStyle,
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE8E8E8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
        )
      ],
    );
  }
}
