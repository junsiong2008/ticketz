import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/screens/participant_detail_screen.dart';
import 'package:ticketz/services/firestore.dart';

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

        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Delete Confirmation'),
                content: Text(
                  'Are you sure you want to delete ${participants[index].englishName}?\n\nID: ${participants[index].id}',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      _clearSearch(context);
                      final FirestoreService firestoreService =
                          FirestoreService();

                      final navigator = Navigator.of(context);

                      try {
                        await firestoreService
                            .deleteParticipant(participants[index].id!)
                            .then((value) => _showSuccessMessage(context));
                        navigator.pop(true);
                      } catch (e) {
                        navigator.pop(false);
                        _showErrorMessage(context);
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: ListTile(
            title: Text(participants[index].englishName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ParticipantDetailScreen(
                        participantId: participants[index].id!,
                      )),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  void _showSuccessMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Participant deleted successfully.',
        ),
      ),
    );
  }

  void _showErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to delete participant.'),
      ),
    );
  }

  void _clearSearch(BuildContext context) {
    final SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    searchProvider.clearQuery();
    searchProvider.disableSearch();
  }
}
