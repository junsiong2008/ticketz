import 'package:ticketz/components/large_button.dart';
import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/components/registered_line_chart.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/screens/qr_attendance_screen.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                          child: Text(
                            'Total Registered',
                            style: TextStyle(
                              fontSize: 16.0,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
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
                              right: 8.0,
                              bottom: 8.0,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRAttendanceScreen()),
                      );
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
}
