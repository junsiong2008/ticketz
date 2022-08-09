import 'package:ticketz/services/firestore.dart';
import 'package:flutter/material.dart';

class QRStateProvider extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();
  bool loading = false;
  bool fail = false;
  bool showScanner = true;
  String? scannedCode;

  Future<void> updateAttendanceStatus(
    String documentId,
    bool isAttended,
    String editorEmail,
  ) async {
    loading = true;
    notifyListeners();

    await firestoreService
        .updateAttendanceStatus(documentId, isAttended, editorEmail)
        .then((value) {
      debugPrint('Then section run');
      scannedCode = documentId;
      loading = false;
      fail = false;
      notifyListeners();
    }).catchError((error, stackTrace) {
      debugPrint('Error section run');
      scannedCode = documentId;
      loading = false;
      fail = true;
      showScanner = false;
      debugPrint('Error set to $error in provider');
    });
    showScanner = false;
    notifyListeners();
  }

  void resetState() {
    showScanner = true;
    fail = false;
    scannedCode = null;
    notifyListeners();
  }
}
