import 'package:ticketz/components/page_title.dart';
import 'package:ticketz/components/participant_list.dart';
import 'package:ticketz/components/primary_button.dart';
import 'package:ticketz/components/search_bar.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/excel_provider.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParticipantScreen extends StatelessWidget {
  const ParticipantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Consumer<SearchProvider>(builder: ((context, value, child) {
            if (value.searchEnabled) {
              return const SearchBar();
            } else {
              return PageTitle(
                pageTitle: 'Participants',
                actions: [
                  IconButton(
                    onPressed: () {
                      Provider.of<SearchProvider>(context, listen: false)
                          .enableSearch();
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
                    child: const Icon(Icons.ios_share),
                    onPressed: () {
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
