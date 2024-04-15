import 'package:ticketz/components/custom_app_bar.dart';
import 'package:ticketz/components/read_only_field.dart';
import 'package:ticketz/components/small_text_button.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/services/firestore.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParticipantDetailScreen extends StatelessWidget {
  const ParticipantDetailScreen({
    super.key,
    required this.participantId,
    // required this.participant,
  });

  // final Participant participant;
  final String participantId;

  void _showSuccessMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Payment status updated successfully.',
        ),
      ),
    );
  }

  void _showErrorMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong while updating payment status.'),
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
              title: 'Participant Profile',
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
                            participant.isPaid
                                ? const Icon(
                                    Icons.credit_score,
                                    color: kPrimaryColor,
                                  )
                                : const Icon(
                                    Icons.credit_card_off,
                                    color: Colors.black45,
                                  ),
                          ],
                        ),
                      ),
                      participant.isPaid
                          ? SmallTextButton(
                              label: 'Mark as Not Paid',
                              onPressed: () {
                                final userEmail =
                                    Provider.of<AuthStateProvider>(
                                  context,
                                  listen: false,
                                ).getCurrentUser!.email;

                                try {
                                  firestoreService.updatePaymentStatus(
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
                              label: 'Mark as Paid',
                              onPressed: () {
                                final userEmail =
                                    Provider.of<AuthStateProvider>(
                                  context,
                                  listen: false,
                                ).getCurrentUser!.email;

                                try {
                                  firestoreService.updatePaymentStatus(
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
                              label: 'Classroom',
                              content: participant.classroom ?? 'N/A',
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
