import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.buttonColor,
    required this.labelColor,
    required this.labelIconData,
    required this.labelText,
    this.onTap,
  }) : super(key: key);

  final Color buttonColor;
  final Color labelColor;
  final IconData labelIconData;
  final String labelText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          color: buttonColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              labelIconData,
              color: labelColor,
              size: 48.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: labelColor,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
