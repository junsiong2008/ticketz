import 'package:flutter/material.dart';
import 'package:ticketz/shared/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: kPrimaryButtonBorder,
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        height: 56.0,
        decoration: kPrimaryButtonBoxDecoration,
        child: Center(
          child: Text(
            label,
            style: kPrimaryButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
