import 'package:flutter/material.dart';
import 'package:ticketz/shared/constants.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final bool readOnly;

  const CustomFormField({
    super.key,
    required this.label,
    this.onChanged,
    this.textEditingController,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.readOnly = false,
  });

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
          maxLines: maxLines,
          controller: textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: kFormFieldColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          readOnly: readOnly,
        )
      ],
    );
  }
}
