import 'package:permission_handler/permission_handler.dart';
import 'package:ticketz/components/large_button.dart';
import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/components/registered_line_chart.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/screens/qr_attendance_screen.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/primary_button.dart';
import 'package:ticketz/providers/excel_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signOut(BuildContext context) {
    final authProvider = Provider.of<AuthStateProvider>(context, listen: false);
    authProvider.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            PageTitle(
              pageTitle: 'Home',
              actions: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    signOut(context);
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 16.0,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      color: kSecondaryColor,
                    ),
                    child: Stack(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,
                            left: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Registered',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          child: Consumer<List<Participant>>(
                            builder: ((context, value, child) {
                              return RegisteredLineChart(
                                participants: value,
                              );
                            }),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                              bottom: 16.0,
                            ),
                            child: Consumer<List<Participant>>(
                              builder: ((context, value, child) {
                                return Text(
                                  value.length.toString(),
                                  style: kChartNumberTextStyle,
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LargeButton(
                    buttonColor: kPrimaryColor,
                    labelColor: Colors.white,
                    labelIconData: Icons.qr_code_scanner,
                    labelText: 'Scan to verify participants attendance',
                    onTap: () async {
                      final navigator = Navigator.of(context);

                      await _checkCameraPermission().then((value) {
                        if (value) {
                          navigator.push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const QRAttendanceScreen()),
                          );
                        } else {
                          _showPermissionDeniedSnackBar(context);
                        }
                      });
                    },
                  ),
                  LargeButton(
                    buttonColor: kTertiaryColor,
                    labelColor: Colors.white,
                    labelIconData: Icons.ios_share,
                    labelText: 'Export participants detail to Excel',
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 16.0,
                                ),
                                child: Wrap(
                                  runSpacing: 16.0,
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<ExcelProvider>(
                                              context,
                                              listen: false,
                                            ).resetState();
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      'Export to Excel?',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Text(
                                      'This will export participant details, payment and attendance status to an Excel file.',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Consumer<ExcelProvider>(
                                        builder: (context, value, child) {
                                      if (value.isError) {
                                        return Text(
                                          value.errorMessage ?? '',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.red,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                      ),
                                      child: Consumer<List<Participant>>(
                                        builder: (context, value, child) {
                                          return PrimaryButton(
                                              label: 'Export',
                                              onTap: () async {
                                                final excelProvider =
                                                    Provider.of<ExcelProvider>(
                                                  context,
                                                  listen: false,
                                                );
                                                await excelProvider
                                                    .exportToExcel(value);
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
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
        content: Text('Please allow camera permission to scan QR code'),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: openAppSettings,
        ),
      ),
    );
  }
}
