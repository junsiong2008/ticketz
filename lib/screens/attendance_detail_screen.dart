import 'package:ticketz/components/custom_app_bar.dart';
import 'package:ticketz/components/read_only_field.dart';
import 'package:ticketz/components/small_text_button.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/services/firestore.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceDetailScreen extends StatelessWidget {
  const AttendanceDetailScreen({
    Key? key,
    required this.participantId,
    // required this.participant,
  }) : super(key: key);

  // final Participant participant;
  final String participantId;

  void _showSuccessMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Attendance status updated successfully.',
        ),
      ),
    );
  }

  void _showErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong while updating attendance.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const CustomAppBar(
              title: 'Participant Attendance Detail',
              actions: [],
              backButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<List<Participant>>(
                    builder: (context, value, child) {
                  final participant = value
                      .firstWhere(((element) => element.id == participantId));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                participant.chineseName != null
                                    ? Text(
                                        '${participant.englishName} ${participant.chineseName}',
                                        style: kNameTextStyle,
                                      )
                                    : Text(
                                        participant.englishName,
                                        style: kNameTextStyle,
                                      ),
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            participant.isAttended
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.red,
                                  ),
                          ],
                        ),
                      ),
                      participant.isAttended
                          ? SmallTextButton(
                              label: 'Mark as Not Attended',
                              onPressed: () {
                                final userEmail =
                                    Provider.of<AuthStateProvider>(
                                  context,
                                  listen: false,
                                ).getCurrentUser!.email;

                                try {
                                  firestoreService.updateAttendanceStatus(
                                    participant.id!,
                                    false,
                                    userEmail ?? 'N/A',
                                  );
                                } catch (e) {
                                  _showErrorMessage(context);
                                }

                                _showSuccessMessage(context);
                              },
                            )
                          : SmallTextButton(
                              label: 'Mark as Attended',
                              onPressed: () {
                                final userEmail =
                                    Provider.of<AuthStateProvider>(
                                  context,
                                  listen: false,
                                ).getCurrentUser!.email;

                                try {
                                  firestoreService.updateAttendanceStatus(
                                    participant.id!,
                                    true,
                                    userEmail ?? 'N/A',
                                  );
                                } catch (e) {
                                  _showErrorMessage(context);
                                }

                                _showSuccessMessage(context);
                              },
                            ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          runSpacing: 16.0,
                          children: [
                            ReadOnlyField(
                              label: 'Participant ID',
                              content: participant.id!,
                            ),
                            ReadOnlyField(
                              label: 'NRIC',
                              content: participant.icNumber,
                            ),
                            ReadOnlyField(
                              label: 'Phone Number',
                              content: participant.phoneNumber,
                            ),
                            ReadOnlyField(
                              label: 'Email Address',
                              content: participant.emailAddress,
                            ),
                            ReadOnlyField(
                              label: 'Student Status',
                              content: participant.studentStatus,
                            ),
                            ReadOnlyField(
                              label: 'Secondary School',
                              content: participant.secondarySchool ?? 'N/A',
                            ),
                            ReadOnlyField(
                              label: 'Unit',
                              content: participant.unit ?? 'N/A',
                            ),
                            ReadOnlyField(
                              label: 'Halal',
                              content:
                                  participant.isHalal ? 'Halal' : 'Non-Halal',
                            ),
                            ReadOnlyField(
                              label: 'Vegetarian',
                              content: participant.isVegetarian
                                  ? 'Vegetarian'
                                  : 'Non-Vegetarian',
                            ),
                            ReadOnlyField(
                              label: 'Allergic',
                              content: participant.allergic ?? 'N/A',
                            ),
                            ReadOnlyField(
                              label: 'Registration Date & Time',
                              content: participant.datetimeCreated.toString(),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
