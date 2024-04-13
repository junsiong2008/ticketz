import 'package:ticketz/components/loading_animation.dart';
import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/components/participant_list.dart';
import 'package:ticketz/components/registration_failed.dart';
import 'package:ticketz/components/registration_form.dart';
import 'package:ticketz/components/registration_successful.dart';
import 'package:ticketz/components/participant_search_bar.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/registration_form_provider.dart';
import 'package:ticketz/providers/registration_state_provider.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParticipantScreen extends StatelessWidget {
  const ParticipantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Consumer<SearchProvider>(builder: ((context, value, child) {
            if (value.searchEnabled) {
              return const ParticipantSearchBar();
            } else {
              return PageTitle(
                pageTitle: 'Participants',
                actions: [
                  IconButton(
                    onPressed: () {
                      final SearchProvider searchProvider =
                          Provider.of<SearchProvider>(context, listen: false);
                      searchProvider.enableSearch();
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                ],
              );
            }
          })),
          Expanded(
            child: Stack(
              children: [
                Consumer2<List<Participant>, SearchProvider>(
                  builder: ((context, participants, searchProvider, child) {
                    if (participants.isEmpty) {
                      return const Center(
                        child: Text('No participant record yet.'),
                      );
                    }

                    if (searchProvider.query != null) {
                      return ParticipantList(
                        participants: participants
                            .where((element) => element.englishName
                                .toLowerCase()
                                .contains(searchProvider.query!.toLowerCase()))
                            .toList(),
                      );
                    } else {
                      return ParticipantList(
                        participants: participants,
                      );
                    }
                  }),
                ),
                Positioned(
                  bottom: 24,
                  right: 24,
                  child: FloatingActionButton(
                    backgroundColor: kPrimaryColor,
                    child: const Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        isDismissible: false,
                        builder: (BuildContext context) {
                          return buildModalBottomSheet(context);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buildModalBottomSheet(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add New Participant',
                    style: kModalSheetTitleTextStyle,
                  ),
                  Consumer<RegistrationStateProvider>(
                    builder: ((context, value, child) {
                      return IconButton(
                        icon: Icon(
                          Icons.close,
                          color: value.loading ? Colors.black26 : kPrimaryColor,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: value.loading
                            ? null
                            : () => closeModalBottomSheet(context),
                      );
                    }),
                  )
                ],
              ),
            ),
            Consumer<RegistrationStateProvider>(
              builder: ((context, value, child) {
                if (value.loading) {
                  return const LoadingAnimation();
                } else {
                  if (value.success) {
                    return const RegistrationSuccessful();
                  } else {
                    if (value.fail) {
                      return RegistrationFailed(
                        errorString: value.errorString,
                      );
                    } else {
                      return const RegistrationForm();
                    }
                  }
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void closeModalBottomSheet(BuildContext context) {
    var registrationStateProvider = Provider.of<RegistrationStateProvider>(
      context,
      listen: false,
    );
    var registrationFormProvider = Provider.of<RegistrationFormProvider>(
      context,
      listen: false,
    );
    Navigator.of(context).pop();
    registrationFormProvider.resetForm();
    registrationStateProvider.resetState();
  }
}
