import 'package:ticketz/components/attendance_list.dart';
import 'package:ticketz/components/custom_app_bar.dart';
import 'package:ticketz/models/participant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManualAttendanceScreen extends StatelessWidget {
  const ManualAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Participant Attendance',
              actions: [],
              backButton: true,
            ),
            Expanded(
              child: Stack(
                children: [
                  Consumer<List<Participant>>(
                    builder: ((context, value, child) {
                      if (value.isEmpty) {
                        return const Center(
                          child: Text('No participant record yet.'),
                        );
                      }
                      return AttendanceList(participants: value);
                    }),
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
