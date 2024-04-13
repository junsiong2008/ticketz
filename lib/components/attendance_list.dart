import 'package:flutter/material.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/screens/attendance_detail_screen.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({
    super.key,
    required this.participants,
  });

  final List<Participant> participants;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: ((context, index) {
        debugPrint('ListView builder called');

        return ListTile(
          title: Text(participants[index].englishName),
          trailing: participants[index].isAttended
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => AttendanceDetailScreen(
                      participantId: participants[index].id!,
                    )),
              ),
            );
          },
        );
      }),
    );
  }
}
