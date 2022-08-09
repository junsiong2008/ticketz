import 'package:flutter/material.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/screens/participant_detail_screen.dart';

class ParticipantList extends StatelessWidget {
  const ParticipantList({
    Key? key,
    required this.participants,
  }) : super(key: key);

  final List<Participant> participants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: ((context, index) {
        debugPrint('ListView builder called');

        return ListTile(
          title: Text(participants[index].englishName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ParticipantDetailScreen(
                      participantId: participants[index].id,
                    )),
              ),
            );
          },
        );
      }),
    );
  }
}
