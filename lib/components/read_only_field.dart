import 'package:flutter/material.dart';
import 'package:ticketz/shared/constants.dart';

class ReadOnlyField extends StatelessWidget {
  const ReadOnlyField({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kReadOnlyLabelTextStyle,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kFormFieldColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          width: double.infinity,
          child: Text(content),
        ),
      ],
    );
  }
}
