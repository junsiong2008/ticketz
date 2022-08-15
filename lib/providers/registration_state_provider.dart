import 'package:flutter/material.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/services/participant_repository.dart';

class RegistrationStateProvider extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  bool fail = false;
  String? errorString;

  Future<void> registerUser(Participant participant) async {
    final ParticipantRepository repository = ParticipantRepository();
    loading = true;
    notifyListeners();

    await repository.addParticipant(participant).then((value) {
      loading = false;
      success = true;
      fail = false;
    }).catchError((error, stackTrace) {
      loading = false;
      success = false;
      fail = true;
      errorString = error.toString();
    });

    notifyListeners();
  }

  void resetState() {
    loading = false;
    success = false;
    fail = false;
    notifyListeners();
  }
}
