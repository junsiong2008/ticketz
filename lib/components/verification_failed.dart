import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/small_text_button.dart';
import 'package:ticketz/providers/qr_state_provider.dart';
import 'package:ticketz/shared/constants.dart';

class VerificationFailed extends StatelessWidget {
  const VerificationFailed({
    super.key,
    required this.scannedCode,
  });
  final String scannedCode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/animations/unapproved-cross.json',
              repeat: false,
              height: 64,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'Verification Failed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              'Failed to verify the following Ticket ID:\n$scannedCode',
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SmallTextButton(
              label: 'Back to Scanner',
              onPressed: () {
                Provider.of<QRStateProvider>(context, listen: false)
                    .resetState();
              },
            ),
          ],
        ),
      ),
    );
  }
}
