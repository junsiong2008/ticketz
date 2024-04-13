import 'package:flutter/material.dart';
import 'package:ticketz/shared/constants.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: kSecondaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
      ),
      child: Text(label),
    );
  }
}
