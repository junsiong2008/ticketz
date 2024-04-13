import 'package:ticketz/components/custom_app_bar.dart';
import 'package:ticketz/components/qr_scanner.dart';
import 'package:ticketz/components/verification_failed.dart';
import 'package:ticketz/components/verification_success.dart';
import 'package:ticketz/providers/qr_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QRAttendanceScreen extends StatelessWidget {
  const QRAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QRStateProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            provider.showScanner
                ? const CustomAppBar(
                    title: 'QR Attendance',
                    actions: [],
                    backButton: true,
                  )
                : CustomAppBar(
                    title: 'Verification Result',
                    actions: <IconButton>[
                      IconButton(
                        onPressed: () {
                          provider.resetState();
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
            Consumer<QRStateProvider>(
              builder: ((context, value, child) {
                if (value.showScanner) {
                  return const QRScanner();
                } else {
                  if (value.fail) {
                    return VerificationFailed(
                      scannedCode: value.scannedCode ?? 'N/A',
                    );
                  } else {
                    return VerificationSuccess(code: value.scannedCode!);
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
