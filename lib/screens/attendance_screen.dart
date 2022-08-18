import 'package:permission_handler/permission_handler.dart';
import 'package:ticketz/components/large_button.dart';
import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/screens/manual_attendance_screen.dart';
import 'package:ticketz/screens/qr_attendance_screen.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            const PageTitle(pageTitle: 'Attendance', actions: []),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16.0,
                children: <LargeButton>[
                  LargeButton(
                    buttonColor: kSecondaryColor,
                    labelColor: Colors.black87,
                    labelIconData: Icons.touch_app_outlined,
                    labelText: 'Mark attendance manually',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return const ManualAttendanceScreen();
                          }),
                        ),
                      );
                    },
                  ),
                  LargeButton(
                      buttonColor: kPrimaryColor,
                      labelColor: Colors.white,
                      labelIconData: Icons.qr_code_scanner,
                      labelText: 'Scan to verify participants attendance',
                      onTap: () async {
                        final navigator = Navigator.of(context);

                        await _checkCameraPermission().then(
                          (value) {
                            if (value) {
                              navigator.push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QRAttendanceScreen()),
                              );
                            } else {
                              _showPermissionDeniedSnackBar(context);
                            }
                          },
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _checkCameraPermission() async {
    final permissionStatus = await Permission.camera.status;

    if (!permissionStatus.isGranted) {
      await Permission.camera.request();
    }
    return await Permission.camera.isGranted;
  }

  void _showPermissionDeniedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please allow camera permission to scan QR code.'),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: openAppSettings,
        ),
      ),
    );
  }
}
