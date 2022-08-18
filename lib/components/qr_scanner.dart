// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:ticketz/providers/auth_state_provider.dart';
// import 'package:ticketz/providers/qr_state_provider.dart';

// class QRScanner extends StatefulWidget {
//   const QRScanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<QRScanner> createState() => _QRScannerState();
// }

// class _QRScannerState extends State<QRScanner> {
//   QRViewController? controller;
//   Barcode? result;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   bool flashOn = false;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: _buildQrView(context),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   Widget _buildQrView(BuildContext context) {
//     // Check the screen size and change the scan area overlay
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;

//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         QRView(
//           key: qrKey,
//           onQRViewCreated: _onQRViewCreated,
//           overlay: QrScannerOverlayShape(
//             borderColor: Colors.red,
//             borderRadius: 10,
//             borderLength: 30,
//             borderWidth: 10,
//             cutOutSize: scanArea,
//           ),
//           onPermissionSet: (controller, p) =>
//               _onPermissionSet(context, controller, p),
//         ),
//         Positioned(
//           bottom: 48,
//           child: IconButton(
//             onPressed: () {
//               setState(() {
//                 flashOn = !flashOn;
//               });
//               controller!.toggleFlash();
//             },
//             icon: Icon(
//               flashOn ? Icons.flashlight_off : Icons.flashlight_on,
//               color: Colors.white,
//               size: 36.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) async {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) async {
//       setState(() {
//         result = scanData;
//       });
//       await updateParticipantAttendance(scanData.code!);
//     });
//   }

//   void _onPermissionSet(
//       BuildContext context, QRViewController controller, bool p) {
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No Permission'),
//         ),
//       );
//     }
//   }

//   Future<void> updateParticipantAttendance(String code) async {
//     final provider = Provider.of<QRStateProvider>(context, listen: false);
//     final email = Provider.of<AuthStateProvider>(
//       context,
//       listen: false,
//     ).getCurrentUser!.email!;
//     await provider.updateAttendanceStatus(code, true, email);
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/providers/qr_state_provider.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  String? qrCode;
  bool? permissionGranted;
  MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: controller,
            onDetect: (qrCode, args) async {
              setState(() {
                this.qrCode = qrCode.rawValue;
              });
              await updateParticipantAttendance(this.qrCode!);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 64,
              color: Colors.black54,
              child: Center(
                child: IconButton(
                  onPressed: () => controller.toggleTorch(),
                  icon: ValueListenableBuilder(
                    valueListenable: controller.torchState,
                    builder: (context, state, child) {
                      switch (state as TorchState) {
                        case TorchState.off:
                          return const Icon(
                            Icons.flashlight_on,
                            color: Colors.white,
                          );
                        case TorchState.on:
                          return const Icon(
                            Icons.flashlight_off,
                            color: Colors.yellow,
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateParticipantAttendance(String code) async {
    final provider = Provider.of<QRStateProvider>(context, listen: false);
    final email = Provider.of<AuthStateProvider>(
      context,
      listen: false,
    ).getCurrentUser!.email!;
    await provider.updateAttendanceStatus(code, true, email);
  }
}
