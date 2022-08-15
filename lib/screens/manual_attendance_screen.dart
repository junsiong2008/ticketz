import 'package:ticketz/components/attendance_list.dart';
import 'package:ticketz/components/custom_app_bar.dart';
import 'package:ticketz/components/search_bar.dart';
import 'package:ticketz/models/participant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/providers/search_provider.dart';

class ManualAttendanceScreen extends StatelessWidget {
  const ManualAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer<SearchProvider>(builder: (context, value, child) {
              if (value.searchEnabled) {
                return const SearchBar();
              } else {
                return CustomAppBar(
                  title: 'Participant Attendance',
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
                  backButton: true,
                );
              }
            }),
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
                        return AttendanceList(
                          participants: participants
                              .where((element) => element.englishName
                                  .toLowerCase()
                                  .contains(
                                      searchProvider.query!.toLowerCase()))
                              .toList(),
                        );
                      } else {
                        return AttendanceList(
                          participants: participants,
                        );
                      }
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
